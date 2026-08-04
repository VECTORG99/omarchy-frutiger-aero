#!/bin/bash
PROFILES=(power-saver balanced performance)
ICONS=(󰾆 󰾅 󰓅)
NAMES=(Ahorro Equilibrado Rendimiento)

current=$(powerprofilesctl get)

case $1 in
  next)
    for i in "${!PROFILES[@]}"; do
      if [[ ${PROFILES[$i]} == "$current" ]]; then
        next=$(( (i + 1) % ${#PROFILES[@]} ))
        powerprofilesctl set "${PROFILES[$next]}"
        break
      fi
    done
    current=$(powerprofilesctl get)
    ;;
esac

for i in "${!PROFILES[@]}"; do
  if [[ ${PROFILES[$i]} == "$current" ]]; then
    jq -n --arg t "${ICONS[$i]}" --arg tt "Perfil: ${NAMES[$i]}" --arg c "$current" '{text:$t, tooltip:$tt, class:$c}'
    break
  fi
done
