#!/bin/bash
CMD="$HOME/.local/bin/eww"

toggle_widget() {
  local name="$1"
  $CMD open "$name" --toggle 2>/dev/null
  sleep 0.3
  local state="off"
  $CMD active-windows 2>/dev/null | grep -qw "^${name}" && state="on"
  $CMD update "${name}_status=${state}" 2>/dev/null
}

case "${1:-}" in
  toggle) toggle_widget "$2" ;;
  *) echo "usage: $0 toggle <name>" && exit 1 ;;
esac
