#!/bin/bash

#telegram alert token & id
BOT_TOKEN="001123456789"
CHAT_ID="01234567890"

#telegram alert bhejne ka funcktion

send_alert() {
    MESSAGE="$1"
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
    -d chat_id="$CHAT_ID" \
    -d text="$MESSAGE"
}

echo "AlertBot ran at $(date)" >> /home/ritik/alertbot-cron.log


#echo "Alertbot ran at $(date)" >> /home/ritik/alertbot-test.log

#Email Address

TO="example@gmail.com"
SUBJECT="System Alert From AlertBot"
BODY=""

#CPU CHECK

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
IS_HIGH_CPU=$(echo "$CPU > 1.0" | bc -l)
if [ "$IS_HIGH_CPU" -eq 1 ]; then
     BODY+="HIGH CPU USAGE: $CPU%\n"
fi

#RAM CHECK

RAM=$(free | grep Mem | awk '{printf "%.2f", $3/$2 * 100 }')
RAM_ALERT=$(echo "$RAM > 1.0" | bc -l)
if [ "$RAM_ALERT" -eq 1 ]; then
      BODY+="HIGH RAM USAGE: $RAM%\n"
fi

#DISK CHECK
DISK=$(df -P / | awk 'NR==2 {print $5+0}')
if [ "$DISK" -gt 1 ]; then
     BODY+="DISK ALMOST FULL: ${DISK}%\n"
fi

#email send if  aleart
#if [[ -n "$BODY" ]]; then
 #    echo -e "$BODY" | mail -s "$SUBJECT" "$TO"
#fi

# Send Email + Write to log (if alert found)
#if [[ -n "$BODY" ]]; then
 #    echo -e "$BODY" | mail -s "$SUBJECT" "$TO"
  #   echo -e "$BODY" >> /home/ritik/alertbot-cron.log   # <-- Log file update
#else
 #    echo -e "No alerts at this time.\n" >> /home/ritik/alertbot-cron.log
#fi


# Send email + telegram + log (if any alert present)
if [[ -n "$BODY" ]]; then
    echo -e "$BODY" | mail -s "$SUBJECT" "$TO"
    send_alert "$BODY"  # ← ye line add kar
    echo -e "$BODY" >> /home/ritik/alertbot-cron.log
else
    echo -e "No alerts at this time.\n" >> /home/ritik/alertbot-cron.log
fi
