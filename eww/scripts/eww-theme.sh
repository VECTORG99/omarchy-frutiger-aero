#!/usr/bin/env bash
# Switch EWW theme between light and dark Frutiger Aero
EWW_DIR="$HOME/.config/eww"
MODE="${1:-dark}"

case "$MODE" in
  light|frutiger-aero)
    ln -sf "$EWW_DIR/eww-light.scss" "$EWW_DIR/eww.scss"
    echo "EWW theme: light"
    ;;
  dark|frutiger-aero-dark|*)
    ln -sf "$EWW_DIR/eww-dark.scss" "$EWW_DIR/eww.scss"
    echo "EWW theme: dark"
    ;;
esac

# Reload EWW if daemon is running
if pgrep -x eww > /dev/null; then
  "$HOME/.local/bin/eww" reload 2>/dev/null || {
    "$HOME/.local/bin/eww" kill 2>/dev/null
    sleep 1
    "$HOME/.local/bin/eww" daemon 2>/dev/null &
  }
fi
