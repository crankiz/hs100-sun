#!/bin/bash
LOGPATH="/var/log/sun/sunschedule.log"
POWERLOG="/var/log/sun/power.log"
CURRENTDATE=$(date +"%Y-%m-%d %H:%M")
CURRENTUNIXTIME=$(date -d "$CURRENTDATE" "+%s")
NEXTTOGGLE=$(head -1 $LOGPATH|awk '{print $1" "$2}')
NEXTUNIXTIME=$(date -d "$NEXTTOGGLE" "+%s")
SUN=$(head -1 $LOGPATH|awk '{print $3}')
port="9999"
pluglist=(
  #192.168.1.3
  #192.168.1.3
)
payload_on="AAAAKtDygfiL/5r31e+UtsWg1Iv5nPCR6LfEsNGlwOLYo4HyhueT9tTu36Lfog=="
payload_off="AAAAKtDygfiL/5r31e+UtsWg1Iv5nPCR6LfEsNGlwOLYo4HyhueT9tTu3qPeow=="

send_to_plug()
{
 for ip in ${pluglist[@]}
    do
   echo -n "$payload" | base64 --decode | nc -v $ip $port > /dev/null
 done
}

remove_event() {
  echo "$(tail -n +2 $LOGPATH)" > $LOGPATH
}

if [ "$CURRENTUNIXTIME" -ge "$NEXTUNIXTIME" ] ; then
  if [ "$SUN" = "set" ] ; then
    payload=$payload_on
    send_to_plug
    remove_event
        echo "$CURRENTDATE Power on" >> $POWERLOG
  else
    payload=$payload_off
    send_to_plug
    remove_event
        echo "$CURRENTDATE Power off" >> $POWERLOG
  fi
else
        echo "$CURRENTDATE Fizzle!" > /dev/null
fi
