mcmonitor-leftronic
===================

Bash frontend to PHP-Minecraft-Query by xPaw
Cron-based bash script for pushing data from a Minecraft server to Leftronic dashboards: http://leftronic.com


Requirements
============
* PHP CLI (any recent-ish version)
* curl
* Query enabled on your Minecraft server


Basic Usage
===========

1. Clone this repo to a location of your choice, preferrably on a server remote to your Minecraft box
2. Edit getstats.sh, plug in your server address and your Leftronic API key
3. Also in getstats.sh, change the various curl commands to point to the name of your Leftronic widget stream names
4. Run getstats.sh to test - your dashboard should be populated.
5. Put getstats.sh on a repeating cron job for continuous updates


Thanks
======
> xPaw for his PHP Minecraft Query script, in which all the heavy lifting is done. (https://github.com/xPaw, http://xpaw.ru)
