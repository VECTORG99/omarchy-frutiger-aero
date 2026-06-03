#!/bin/bash
player=$(playerctl -l 2>/dev/null | head -1)
status=$(playerctl status 2>/dev/null)

if [[ -z $player || $status == "Stopped" ]]; then
  echo '{"text": "", "class": "stopped", "tooltip": "Sin reproducción"}'
  exit 0
fi

case $player in
  spotify*) icon="" ;;
  mpv*) icon="" ;;
  vlc*) icon="" ;;
  firefox*) icon="" ;;
  chromium*) icon="" ;;
  *) icon="" ;;
esac

if [[ $status == "Paused" ]]; then
  echo "{\"text\": \"$icon\", \"class\": \"paused\", \"tooltip\": \"$player (pausado)\"}"
else
  echo "{\"text\": \"$icon\", \"class\": \"playing\", \"tooltip\": \"$player (reproduciendo)\"}"
fi
