#!/bin/bash
FLAG=/tmp/caffeine_mode
PIDFILE=/tmp/caffeine_inhibit.pid

case $1 in
  toggle)
    if [[ -f $FLAG ]]; then
      rm -f "$FLAG" "$PIDFILE"
      kill "$(cat "$PIDFILE" 2>/dev/null)" 2>/dev/null
      pkill -RTMIN+10 waybar
    else
      touch "$FLAG"
      systemd-inhibit --what=sleep:idle --who=caffeine --why="Caffeine mode" sleep infinity &
      echo $! > "$PIDFILE"
      pkill -RTMIN+10 waybar
    fi
    ;;
esac

if [[ -f $FLAG ]]; then
  echo '{"text": "󰅶", "class": "active", "tooltip": "Caffeine — no suspender"}'
else
  echo '{"text": "󰛊", "class": "", "tooltip": "Caffeine desactivado — click para activar"}'
fi
