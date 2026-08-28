#!/usr/bin/env bash
set -euo pipefail

EWW_CMD="$(command -v eww || echo "$HOME/.local/bin/eww")"

toggle_widget() {
  local name="$1"
  "$EWW_CMD" open "$name" --toggle 2>/dev/null
  sleep 0.3
  local state="off"
  "$EWW_CMD" active-windows 2>/dev/null | grep -qw "^${name}" && state="on"
  "$EWW_CMD" update "${name}_status=${state}" 2>/dev/null
}

case "${1:-}" in
  toggle) toggle_widget "$2" ;;
  *) echo "usage: $0 toggle <name>" && exit 1 ;;
esac
