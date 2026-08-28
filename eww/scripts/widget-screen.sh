#!/usr/bin/env bash
set -euo pipefail

# Move a specific EWW widget to a different screen
EWW_CMD="$(command -v eww || echo "$HOME/.local/bin/eww")"
WIDGET="${1:-}"
SCREEN="${2:-}"

if [ -z "$WIDGET" ] || [ -z "$SCREEN" ]; then
  echo "usage: $0 <widget> <screen>"
  exit 1
fi

# Validate screen index against actual monitors
monitor_count=$(hyprctl -j monitors 2>/dev/null | jq 'length' 2>/dev/null || echo 1)
if [ "$SCREEN" -ge "$monitor_count" ] 2>/dev/null; then
  echo "error: screen $SCREEN not available (only $monitor_count monitor(s) connected)" >&2
  exit 1
fi

# Check if widget is open
if "$EWW_CMD" active-windows 2>/dev/null | grep -qw "^$WIDGET"; then
  "$EWW_CMD" close "$WIDGET" 2>/dev/null
  sleep 0.3
  "$EWW_CMD" open "$WIDGET" --screen "$SCREEN" 2>/dev/null
else
  "$EWW_CMD" open "$WIDGET" --screen "$SCREEN" 2>/dev/null
fi
