#!/bin/bash
MONTH=( $(echo {0..30} | xargs -I{} -d ' ' date --date=+{}' day' +"%Y-%m-%d") )
LAT=#"1.000000"
LNG=#"1.000000"
LOG="/var/log/sun/sunschedule.log"
DELAY_RISE="60 min"
DELAY_SET="0 min"

PARSE () {
     sed 's/\(.*\)T\([0-9]*:[0-9]*\).*/\1 \2/'|tr -d "\""
}

> $LOG
for DAY in "${MONTH[@]}" ; do
  SUNTIME=$(curl --silent \
                 --request GET \
                 --url 'https://api.sunrise-sunset.org/json?lat='$LAT'&lng='$LNG'&date='$DAY'&formatted=0' \
                 --header 'accept: application/json')
  SUNRISE=$(echo "$SUNTIME"|jq '.results.sunrise'|PARSE)
  SUNSET=$(echo "$SUNTIME"|jq '.results.sunset'|PARSE)
  SUNRISE_D=$(date -d "$SUNRISE $DELAY_RISE" +"%Y-%m-%d %H:%M")
  SUNSET_D=$(date -d "$SUNSET $DELAY_SET" +"%Y-%m-%d %H:%M")
  echo -e "$SUNRISE_D rise\\n$SUNSET_D set" >> $LOG
done
