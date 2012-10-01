#!/bin/bash
#getstats.sh
#Grab stats for a minecraft server

###CONFIG###
#Enter your API Key for Leftronic here:
apikey=""
server=""


###############################################

#Really dumb method of setting our CWD - assume the PHP scripts are in the same folder as the .sh
cd "$(dirname "$0")"

#Post to a "point" endpoint (only takes one argument).
function postpoint {
curl -s -X POST -k -d '{"accessKey": "'$apikey'", "streamName": "'$1'", "point": "'$2'"}' https://www.leftronic.com/customSend/
}

#Post to a "label" endpoint (using eval shenanigans to nest vars)
function postlabel {
postvar=`echo -n $ ; echo -n $2`
postdata=`eval echo $postvar`
echo Post data: $postdata
curl -s -X POST -k -d '{"accessKey": "'$apikey'", "streamName": "'$1'", "point": {"label": "'"$postdata"'"}}' https://www.leftronic.com/customSend/
}


#Get players online via PHP query and post the result
#TODO: This is a horribly, terribly messy way to parse the script..
playersonline=`php query.php | grep Players | head -n1 | sed 's/.*>//g' | sed 's/ //g'`
echo Players online: $playersonline
echo Posting to current count
postpoint PlayerCount $playersonline
echo
echo Posting to statistical graph
postpoint UsersOverTime $playersonline
echo


#Process server status
#Let's run a ping
ping -c1 $server > /dev/null 2>&1
#Status: ping exit status
pingstatus=$?
if [ $pingstatus = 0 ]; then
poststatus=1
else
poststatus=10
fi
echo Ping status: $pingstatus
echo Post status: $poststatus
echo Posting to server status..
postpoint ServerStatus $poststatus
echo

#Get uptime, load, memory
#TODO: There has to be a better way to handle this.
echo Retrieving system statistics..
upstring=`ssh root@mc.shenanigancraft.tk uptime`
uptime=`echo $upstring | pcregrep -o '(?<=up ).*?,.*?(?=,)'`
echo System Uptime: $uptime
loadavg=`echo $upstring | pcregrep -o '(?<=load average: ).*'`
echo System Load Average: $loadavg
memstring=`ssh root@mc.shenanigancraft.tk free -m`
memused=`echo $memstring | pcregrep -o '(?<=cache: )\d*'` 
echo Memory used: $memused
diskused=`ssh root@mc.shenanigancraft.tk df -m | awk 'NR==2' | awk {'print $3'}`
echo Disk used: $diskused
echo Posting system statistics..

#Post collected data
#This is not a typo! Pass the variable name into postlabel, not the actual $variable
postlabel LoadAvg loadavg
echo
postlabel SystemUptime uptime
echo
postpoint MemUsed $memused
echo
postpoint DiskUsed $diskused