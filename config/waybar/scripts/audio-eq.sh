#!/bin/bash
export LC_ALL=en_US.utf8

# Check if audio is playing
inputs=$(pactl list sink-inputs 2>/dev/null | grep -c "State: RUNNING")
muted=$(pamixer --get-mute 2>/dev/null)

if [[ $muted == "true" ]]; then
  echo '{"text": "", "class": "muted", "tooltip": "Audio silenciado"}'
  exit 0
fi

if (( inputs == 0 )); then
  echo '{"text": "", "class": "idle", "tooltip": "Sin reproducción de audio"}'
  exit 0
fi

vol=$(pamixer --get-volume 2>/dev/null)
vol=${vol:-0}

# Visualizer bars — animate with the current count
count=$(( RANDOM % 5 + 3 ))
chars=()
for (( i = 0; i < count; i++ )); do
  h=$(( RANDOM % 4 + 1 ))
  case $h in
    1) chars+=("▁") ;;
    2) chars+=("▃") ;;
    3) chars+=("▅") ;;
    4) chars+=("▇") ;;
  esac
done

bars=$(IFS=; echo "${chars[*]}")

echo "{\"text\": \"$bars\", \"class\": \"playing\", \"tooltip\": \"Volumen: ${vol}% — reproduciendo audio\"}"
