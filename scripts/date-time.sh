#!/usr/bin/env bash
# Shared date/time library for Waybar and EWW clocks
# Provides consistent date formatting across the theme
# Usage: source this file, then call format_date_time <format>

set -euo pipefail

# Format date/time according to the given format string
# Formats:
#   horizontal  - "Monday 15/01 03:45 PM" (Waybar horizontal)
#   vertical    - "Monday\n15/01\n03:45\nPM" (Waybar vertical)
#   eww         - JSON with hour, minute, second, ampm, weekday, day, month, year, tz (EWW)
format_date_time() {
  local format="${1:-horizontal}"
  
  case "$format" in
    horizontal)
      LC_TIME=en_US.UTF-8 date "+%A %d/%m %I:%M %p"
      ;;
    vertical)
      LC_TIME=en_US.UTF-8 date '+%A\n%d/%m\n%I:%M\n%p'
      ;;
    eww)
      # Single date call + read into variables (optimized)
      read -r hour minute second ampm weekday day month year tz <<EOF
$(LC_TIME=en_US.UTF-8 date +'%I %M %S %p %a %d %b %Y %Z')
EOF
      jq -n \
        --arg hour "$hour" --arg minute "$minute" --arg second "$second" \
        --arg ampm "$ampm" --arg weekday "$weekday" --arg day "$day" \
        --arg month "$month" --arg year "$year" --arg tz "$tz" \
        '{hour:$hour, minute:$minute, second:$second, ampm:$ampm, weekday:$weekday, day:$day, month:$month, year:$year, tz:$tz}'
      ;;
    *)
      echo "error: unknown format '$format'" >&2
      return 1
      ;;
  esac
}

# Get tooltip (full date string)
get_tooltip() {
  date
}