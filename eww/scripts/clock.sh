#!/bin/bash
# Clock widget — single date call (was 9 forks, now 1)
set -euo pipefail

# Single date call + read into variables
read -r hour minute second ampm weekday day month year tz <<EOF
$(LC_TIME=en_US.UTF-8 date +'%I %M %S %p %a %d %b %Y %Z')
EOF

jq -n \
  --arg hour "$hour" --arg minute "$minute" --arg second "$second" \
  --arg ampm "$ampm" --arg weekday "$weekday" --arg day "$day" \
  --arg month "$month" --arg year "$year" --arg tz "$tz" \
  '{hour:$hour, minute:$minute, second:$second, ampm:$ampm, weekday:$weekday, day:$day, month:$month, year:$year, tz:$tz}'
