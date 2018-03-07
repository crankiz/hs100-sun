# hs100-sun

sun.sh - Creates a schedule based on sunrise and sunset via a sun API
power.sh - Sends payloads to TP-link smart plug hs100 to turn on and off based on the schedule

Use these script with crontab


```shell
# m h  dom mon dow   command
15 00 * * 1 /usr/local/bin/sun >/dev/null 2>&1
* * * * * /usr/local/bin/power >/dev/null 2>&1
```
