#!/usr/bin/env bash
EWW_DIR="$HOME/.config/eww"
EWW="$HOME/.local/bin/eww"
MODE="${1:-auto}"

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

if pgrep -x eww > /dev/null; then
  "$EWW" kill 2>/dev/null
  sleep 1
fi
rm -f /run/user/$(id -u)/eww-server_* 2>/dev/null
"$EWW" daemon 2>/dev/null &
sleep 3
"$EWW" update cal_data="$(python3 "$EWW_DIR/scripts/calendar.sh" 0)" 2>/dev/null
"$EWW" update weather_data="$(cat "$HOME/.cache/eww-weather/weather.json" 2>/dev/null || echo '{}')" 2>/dev/null
