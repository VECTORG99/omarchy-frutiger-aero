#!/bin/bash
CACHE=/tmp/network_speed_cache
INTERFACE=$(ip route get 8.8.8.8 2>/dev/null | awk '{print $5; exit}')

if [[ -z $INTERFACE ]]; then
  echo '{"text": "󰤮", "tooltip": "Sin conexión", "class": "disconnected"}'
  exit 0
fi

read -r rx_bytes tx_bytes < <(awk -v iface="$INTERFACE" '$1 ~ iface":" {print $2, $10}' /proc/net/dev 2>/dev/null)
rx_bytes=${rx_bytes:-0}
tx_bytes=${tx_bytes:-0}

if [[ ! -f $CACHE ]]; then
  echo "$rx_bytes $tx_bytes $(date +%s)" > "$CACHE"
  jq -nc '{text:"󰛳 0B/s 󰛲 0B/s", tooltip:"Midiendo...", class:""}'
  exit 0
fi

read -r old_rx old_tx old_time < "$CACHE"
now=$(date +%s)
delta=$(( now - old_time ))
[[ $delta -lt 1 ]] && delta=1

rx_speed=$(( (rx_bytes - old_rx) / delta ))
tx_speed=$(( (tx_bytes - old_tx) / delta ))

format_speed() {
  local val=$1
  if (( val >= 1048576 )); then
    awk "BEGIN { printf \"%.1fMB/s\", $val / 1048576 }"
  elif (( val >= 1024 )); then
    awk "BEGIN { printf \"%.0fKB/s\", $val / 1024 }"
  else
    echo "${val}B/s"
  fi
}

down=$(format_speed $rx_speed)
up=$(format_speed $tx_speed)

echo "$rx_bytes $tx_bytes $now" > "$CACHE"
jq -nc --arg t "󰛳 $down 󰛲 $up" --arg tt "↓ $down  ↑ $up" '{text:$t, tooltip:$tt, class:""}'
