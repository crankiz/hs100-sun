# hs100-sun

### sun.sh 
Creates a schedule based on sunrise and sunset via a sun API
Change coordinates in the script and the API will give you time for sunrise and sunset

### power.sh
Sends payloads to TP-link smart plug hs100 to turn on and off based on the schedule
Change the array with IP-addresses in the script to your hs100 IP

Use these script with crontab

#### Example
```shell
# m h  dom mon dow   command
15 00 * * 1 /usr/local/bin/sun >/dev/null 2>&1
* * * * * /usr/local/bin/power >/dev/null 2>&1
```
