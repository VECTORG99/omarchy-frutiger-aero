#!/usr/bin/env bash
set -euo pipefail

# Generate dynamic screen buttons for widget-ctl
# Usage: ./generate-screen-buttons.sh <widget-name>

WIDGET="${1:-}"

if [ -z "$WIDGET" ]; then
  echo "usage: $0 <widget-name>" >&2
  exit 1
fi

monitors=$(hyprctl -j monitors 2>/dev/null | jq -c '.[] | {id: .id, name: .name}' 2>/dev/null)

if [ -z "$monitors" ]; then
  # Fallback to single monitor
  echo '(button :onclick "bash scripts/widget-screen.sh '"$WIDGET"' 0" (label :text "1" :class "ctl-scr"))'
  exit 0
fi

# Generate buttons for each monitor
echo "$monitors" | while IFS= read -r mon; do
  id=$(echo "$mon" | jq -r '.id')
  # Use 1-based index for display
  display_num=$((id + 1))
  echo "(button :onclick \"bash scripts/widget-screen.sh $WIDGET $id\" (label :text \"$display_num\" :class \"ctl-scr\"))"
done