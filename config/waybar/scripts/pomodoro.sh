#!/bin/bash
STATE_FILE=/tmp/pomodoro_state
[[ ! -f $STATE_FILE ]] && echo "stopped 25 0" > "$STATE_FILE"

read -r state minutes seconds < "$STATE_FILE"

case $1 in
  start)
    echo "running 25 0" > "$STATE_FILE"
    notify-send " Pomodoro" "Trabajo 25 min — enfoque!" -u low
    pkill -RTMIN+12 waybar
    exit 0
    ;;
  stop)
    echo "stopped 25 0" > "$STATE_FILE"
    notify-send " Pomodoro" "Timer cancelado" -u low
    pkill -RTMIN+12 waybar
    exit 0
    ;;
esac

if [[ $state == "running" ]]; then
  total_seconds=$(( minutes * 60 + seconds ))
  if (( total_seconds <= 0 )); then
    notify-send " Pomodoro" "Tiempo! Tomate un descanso" -u critical
    echo "break 5 0" > "$STATE_FILE"
    pkill -RTMIN+12 waybar
    exit 0
  fi

  display_min=$(( total_seconds / 60 ))
  display_sec=$(( total_seconds % 60 ))
  printf -v time_str "%d:%02d" "$display_min" "$display_sec"

  remaining=$(( total_seconds - 1 ))
  next_min=$(( remaining / 60 ))
  next_sec=$(( remaining % 60 ))
  echo "running $next_min $next_sec" > "$STATE_FILE"

  echo "{\"text\": \" $time_str\", \"class\": \"running\", \"tooltip\": \"Pomodoro — restan ${display_min}m ${display_sec}s\"}"
elif [[ $state == "break" ]]; then
  total_seconds=$(( minutes * 60 + seconds ))
  if (( total_seconds <= 0 )); then
    notify-send " Pomodoro" "Descanso terminado! A trabajar" -u critical
    echo "stopped 25 0" > "$STATE_FILE"
    pkill -RTMIN+12 waybar
    exit 0
  fi

  display_min=$(( total_seconds / 60 ))
  display_sec=$(( total_seconds % 60 ))
  printf -v time_str "%d:%02d" "$display_min" "$display_sec"

  remaining=$(( total_seconds - 1 ))
  next_min=$(( remaining / 60 ))
  next_sec=$(( remaining % 60 ))
  echo "break $next_min $next_sec" > "$STATE_FILE"

  echo "{\"text\": \" $time_str\", \"class\": \"break\", \"tooltip\": \"Descanso — restan ${display_min}m ${display_sec}s\"}"
else
  echo "{\"text\": \"\", \"class\": \"stopped\", \"tooltip\": \"Pomodoro detenido — click para iniciar\"}"
fi
