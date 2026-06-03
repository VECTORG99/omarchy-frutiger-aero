#!/bin/bash
CACHE_DIR=/tmp/playerctl-cover
mkdir -p "$CACHE_DIR"

art_url=$(playerctl metadata mpris:artUrl 2>/dev/null)
status=$(playerctl status 2>/dev/null)

if [[ -z $art_url || $status == "Stopped" ]]; then
  echo '{"text": "", "class": "stopped", "alt": "No music"}'
  exit 0
fi

hash=$(echo "$art_url" | md5sum | cut -c1-8)
cache_file="$CACHE_DIR/$hash.jpg"

if [[ ! -f $cache_file ]]; then
  if [[ $art_url == file://* ]]; then
    cp "${art_url#file://}" "$cache_file" 2>/dev/null
  else
    curl -sL "$art_url" -o "$cache_file" 2>/dev/null
  fi
  [[ ! -f $cache_file ]] && echo '{"text": "", "class": "stopped"}' && exit 0
fi

title=$(playerctl metadata title 2>/dev/null)
artist=$(playerctl metadata artist 2>/dev/null)
tooltip="${title:-?} — ${artist:-?}"

if [[ $status == "Paused" ]]; then
  echo "{\"image\": \"$cache_file\", \"class\": \"paused\", \"alt\": \"Pausado\", \"tooltip\": \"$tooltip\"}"
else
  echo "{\"image\": \"$cache_file\", \"class\": \"playing\", \"alt\": \"$title\", \"tooltip\": \"$tooltip\"}"
fi
