#!/usr/bin/env bash
# Opacity control — get/set inactive_opacity for Hyprland
# Persists value to ~/.config/hypr/.opacity_state
set -euo pipefail

STATE_FILE="$HOME/.config/hypr/.opacity_state"
DEFAULT_OPACITY="0.72"

# Ensure state file exists with default
init_state() {
  if [ ! -f "$STATE_FILE" ]; then
    echo "$DEFAULT_OPACITY" > "$STATE_FILE"
  fi
}

case "${1:-get}" in
  get)
    init_state
    current=$(cat "$STATE_FILE" 2>/dev/null || echo "$DEFAULT_OPACITY")
    # Convert to percentage for display (0.72 -> 72)
    pct=$(awk "BEGIN { printf \"%.0f\", $current * 100 }")
    jq -n --arg v "$current" --arg p "$pct" '{opacity:$v, percent:$p}'
    ;;

  set)
    new_val="${2:-$DEFAULT_OPACITY}"
    # Validate: must be a number between 0.0 and 1.0
    if ! echo "$new_val" | grep -qP '^0?\.\d+$|^1\.0$|^0$|^1$'; then
      echo "error: invalid opacity value (must be 0.0-1.0)" >&2
      exit 1
    fi
    init_state
    echo "$new_val" > "$STATE_FILE"
    hyprctl eval "hl.config({decoration={inactive_opacity=$new_val}})" > /dev/null 2>&1 || true
    pct=$(awk "BEGIN { printf \"%.0f\", $new_val * 100 }")
    jq -n --arg v "$new_val" --arg p "$pct" '{opacity:$v, percent:$p}'
    ;;

  apply)
    # Apply saved state to Hyprland (used on startup/reload)
    init_state
    current=$(cat "$STATE_FILE" 2>/dev/null || echo "$DEFAULT_OPACITY")
    hyprctl eval "hl.config({decoration={inactive_opacity=$current}})" > /dev/null 2>&1 || true
    ;;

  *)
    echo "usage: $0 {get|set <0.0-1.0>|apply}" >&2
    exit 1
    ;;
esac
