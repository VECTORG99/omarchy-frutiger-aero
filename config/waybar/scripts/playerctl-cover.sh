#!/bin/bash
player=$(playerctl -l 2>/dev/null | head -1)
status=$(playerctl status 2>/dev/null)

if [[ -z $player || $status == "Stopped" ]]; then
  jq -c -n '{text:"", class:"stopped", tooltip:"Sin reproducción"}'
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
  jq -c -n --arg t "$icon" --arg tt "$player (pausado)" '{text:$t, class:"paused", tooltip:$tt}'
else
  jq -c -n --arg t "$icon" --arg tt "$player (reproduciendo)" '{text:$t, class:"playing", tooltip:$tt}'
fi
