mcmonitor-leftronic
===================

A bash frontend to xPaw's PHP-Minecraft-Query.. push data from a Minecraft server to Leftronic web dashboards (http://leftronic.com)


Requirements
============
* Minecraft, any version since release 1.2 with query enabled
* PHP CLI (any recent-ish version)
* curl
* A Leftronic account (free for single dashboards with custom data) and your API key
* SSH keys set up between your monitoring server and your Minecraft server

Basic Usage
===========

1. Clone this repo to a location of your choice, preferrably on a server remote to your Minecraft box.
2. Edit getstats.sh, plug in your server address, API key, the names of your Leftronic widget streams, and the SSH account to use.
3. Edit query.php, plug in your server address and query port.
4. Run getstats.sh to test - your dashboard should be populated.
5. Put getstats.sh on a repeating cron job for continuous updates


Thanks
======
- **xPaw** for his PHP Minecraft Query script, in which all the heavy lifting is done. (https://github.com/xPaw, http://xpaw.ru)
