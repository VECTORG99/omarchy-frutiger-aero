#!/bin/bash
set -euo pipefail
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/eww-music"
ART_DIR="$CACHE_DIR/art"
DEFAULT_ART="$HOME/.config/eww/assets/icons/music-default.svg"
mkdir -p "$ART_DIR"
PLAYER=$(playerctl -l 2>/dev/null | head -1 || echo "")
if [ -z "$PLAYER" ]; then
  jq -n --arg art "$DEFAULT_ART" '{title:"No Music",artist:"---",status:"stopped",art:$art}'
  exit 0
fi
TITLE=$(playerctl -p "$PLAYER" metadata xesam:title 2>/dev/null | head -c 80 || echo "---")
ARTIST=$(playerctl -p "$PLAYER" metadata xesam:artist 2>/dev/null | head -c 80 || echo "---")
STATUS=$(playerctl -p "$PLAYER" status 2>/dev/null || echo "stopped")
ART_URL=$(playerctl -p "$PLAYER" metadata mpris:artUrl 2>/dev/null || echo "")
ART_FILE="$DEFAULT_ART"
if [ -n "$ART_URL" ] && [ "$ART_URL" != "$DEFAULT_ART" ]; then
  ART_HASH=$(echo "$ART_URL" | md5sum | cut -d' ' -f1)
  ART_FILE="$ART_DIR/$ART_HASH.jpg"
  [ ! -f "$ART_FILE" ] && curl -sfL "$ART_URL" -o "$ART_FILE" 2>/dev/null || true
  [ ! -f "$ART_FILE" ] && ART_FILE="$DEFAULT_ART"
fi
jq -n --arg t "$TITLE" --arg a "$ARTIST" --arg s "$STATUS" --arg art "$ART_FILE" \
  '{title:$t, artist:$a, status:$s, art:$art}'
