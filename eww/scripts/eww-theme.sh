#!/usr/bin/env bash
EWW_DIR="$HOME/.config/eww"
MODE="${1:-auto}"

# Auto-detect: check if dark theme is active via Omarchy or color scheme
if [ "$MODE" = "auto" ]; then
  THEME=$(omarchy theme current 2>/dev/null || echo "")
  case "$THEME" in
    *[Dd]ark*) MODE="dark" ;;
    *) MODE="light" ;;
  esac
fi

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
