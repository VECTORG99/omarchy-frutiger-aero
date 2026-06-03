#!/bin/bash
FLAG=/tmp/caffeine_mode
PIDFILE=/tmp/caffeine_inhibit.pid

case $1 in
  toggle)
    if [[ -f $FLAG ]]; then
      rm -f "$FLAG" "$PIDFILE"
      kill "$(cat "$PIDFILE" 2>/dev/null)" 2>/dev/null
      echo '{"text": "", "class": "", "tooltip": "Caffeine desactivado"}'
    else
      touch "$FLAG"
      systemd-inhibit --what=sleep:idle --who=caffeine --why="Caffeine mode" sleep infinity &
      echo $! > "$PIDFILE"
      echo '{"text": "󰅶", "class": "active", "tooltip": "Caffeine activado — no suspender"}'
    fi
    ;;
  *)
    if [[ -f $FLAG ]]; then
      echo '{"text": "󰅶", "class": "active", "tooltip": "Caffeine activado — no suspender"}'
    else
      echo '{"text": "", "class": "", "tooltip": "Caffeine desactivado"}'
    fi
    ;;
esac
