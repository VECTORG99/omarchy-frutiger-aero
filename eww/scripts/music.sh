#!/usr/bin/env bash
# Frutiger Aero Music Widget — playerctl metadata + album art
set -euo pipefail

CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/eww-music"
ART_DIR="$CACHE_DIR/art"
DEFAULT_ART="$HOME/.config/eww/assets/icons/music-default.svg"
mkdir -p "$ART_DIR"

PLAYER=$(playerctl -l 2>/dev/null | head -1 || echo "")

if [ -z "$PLAYER" ]; then
  echo '{"title":"No Music","artist":"---","status":"stopped","art":"'$DEFAULT_ART'","position":"0","length":"0","percent":"0"}'
  exit 0
fi

# Metadata
TITLE=$(playerctl -p "$PLAYER" metadata xesam:title 2>/dev/null | head -c 80 || echo "---")
ARTIST=$(playerctl -p "$PLAYER" metadata xesam:artist 2>/dev/null | head -c 80 || echo "---")
STATUS=$(playerctl -p "$PLAYER" status 2>/dev/null || echo "stopped")
ART_URL=$(playerctl -p "$PLAYER" metadata mpris:artUrl 2>/dev/null || echo "")

# Position / Length
POS=$(playerctl -p "$PLAYER" position 2>/dev/null || echo "0")
LEN=$(playerctl -p "$PLAYER" metadata mpris:length 2>/dev/null || echo "1")

# Calculate percent
if [ "$LEN" != "0" ] && [ "$LEN" != "1" ] && [ "$POS" != "0" ]; then
  PERCENT=$(python3 -c "print(int(($POS / $LEN) * 100))")
else
  PERCENT="0"
fi

# Album art: download if URL and not cached
ART_FILE="$DEFAULT_ART"
if [ -n "$ART_URL" ] && [ "$ART_URL" != "$DEFAULT_ART" ]; then
  ART_HASH=$(echo "$ART_URL" | md5sum | cut -d' ' -f1)
  ART_FILE="$ART_DIR/$ART_HASH.jpg"
  if [ ! -f "$ART_FILE" ] && [ -n "$ART_URL" ]; then
    if echo "$ART_URL" | grep -q "^file://"; then
      cp "$(echo "$ART_URL" | sed 's|^file://||')" "$ART_FILE" 2>/dev/null || true
    else
      curl -sfL "$ART_URL" -o "$ART_FILE" 2>/dev/null || true
    fi
  fi
  [ ! -f "$ART_FILE" ] && ART_FILE="$DEFAULT_ART"
fi

# Trim trailing zeros from position/length
POS_INT=$(printf "%.0f" "$POS" 2>/dev/null || echo "0")
LEN_INT=$(printf "%.0f" "$LEN" 2>/dev/null || echo "0")

echo "{\"title\":\"$TITLE\",\"artist\":\"$ARTIST\",\"status\":\"$STATUS\",\"art\":\"$ART_FILE\",\"position\":\"$POS_INT\",\"length\":\"$LEN_INT\",\"percent\":\"$PERCENT\"}"
