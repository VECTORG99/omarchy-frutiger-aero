#!/usr/bin/env bash
hour=$(LC_TIME=en_US.UTF-8 date +'%I')
minute=$(LC_TIME=en_US.UTF-8 date +'%M')
second=$(LC_TIME=en_US.UTF-8 date +'%S')
ampm=$(LC_TIME=en_US.UTF-8 date +'%p')
weekday=$(LC_TIME=en_US.UTF-8 date +'%a')
day=$(LC_TIME=en_US.UTF-8 date +'%d')
month=$(LC_TIME=en_US.UTF-8 date +'%b')
year=$(LC_TIME=en_US.UTF-8 date +'%Y')
tz=$(LC_TIME=en_US.UTF-8 date +'%Z')
jq -n \
  --arg hour "$hour" --arg minute "$minute" --arg second "$second" \
  --arg ampm "$ampm" --arg weekday "$weekday" --arg day "$day" \
  --arg month "$month" --arg year "$year" --arg tz "$tz" \
  '{hour:$hour, minute:$minute, second:$second, ampm:$ampm, weekday:$weekday, day:$day, month:$month, year:$year, tz:$tz}'
