#!/bin/bash
export LC_ALL=en_US.utf8

muted=$(pamixer --get-mute 2>/dev/null)
vol=$(pamixer --get-volume 2>/dev/null)
vol=${vol:-0}

if [[ $muted == "true" ]]; then
  echo '{"text": "", "class": "muted", "tooltip": "Audio silenciado"}'
  exit 0
fi

# PipeWire/PulseAudio: count active non-corked streams
active=$(pactl list sink-inputs 2>/dev/null | grep -c "Corked: no")

if (( active == 0 )); then
  echo "{\"text\": \"▂▄▆█\", \"class\": \"idle\", \"tooltip\": \"Volumen: ${vol}% — sin reproducción\"}"
  exit 0
fi

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

echo "{\"text\": \"$bars\", \"class\": \"playing\", \"tooltip\": \"Volumen: ${vol}% — reproduciendo\"}"
