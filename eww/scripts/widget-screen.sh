#!/usr/bin/env bash
# Move a specific EWW widget to a different screen
EWW="$HOME/.local/bin/eww"
WIDGET="$1"
SCREEN="$2"

if [ -z "$WIDGET" ] || [ -z "$SCREEN" ]; then
  echo "usage: $0 <widget> <screen>"
  exit 1
fi

# Check if widget is open
if $EWW active-windows 2>/dev/null | grep -qw "^$WIDGET"; then
  $EWW close "$WIDGET" 2>/dev/null
  sleep 0.3
  $EWW open "$WIDGET" --screen "$SCREEN" 2>/dev/null
else
  $EWW open "$WIDGET" --screen "$SCREEN" 2>/dev/null
fi
