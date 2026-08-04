#!/usr/bin/env bash
# System Monitor — CPU, GPU, RAM, DISK (rounded integers)
set -euo pipefail

# CPU usage
cpu=$(top -bn1 2>/dev/null | grep "Cpu(s)" | awk '{print int($2+$4)}' || echo "0")

# CPU temp
cpu_temp=$(sensors 2>/dev/null | grep -oP 'Tctl:\s+\+\K[\d.]+' | head -1 | cut -d. -f1 || echo "0")

# GPU — detect vendor and use appropriate tool
gpu_usage="0"
gpu_temp="0"
if command -v nvidia-smi &>/dev/null; then
  gpu_usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null | head -1 || echo "0")
  gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -1 || echo "0")
elif command -v sensors &>/dev/null; then
  # AMD/Intel GPU via lm-sensors — look for GPU-related temp sensors
  gpu_temp=$(sensors 2>/dev/null | grep -iE 'edge|gpu|junction|temp1' | head -1 | grep -oP '[\d.]+' | head -1 | cut -d. -f1 || echo "0")
  # AMD GPU usage via sysfs (amdgpu)
  if [ -f /sys/class/drm/card0/device/gpu_busy_percent ]; then
    gpu_usage=$(cat /sys/class/drm/card0/device/gpu_busy_percent 2>/dev/null || echo "0")
  fi
fi

# RAM
ram_info=$(free -m 2>/dev/null | awk '/^Mem:/ {printf "%d", ($3/$2)*100}')
[ -z "$ram_info" ] && ram_info="0"

# Disk root
disk_info=$(df / --output=pcent 2>/dev/null | tail -1 | tr -d ' %')
[ -z "$disk_info" ] && disk_info="0"

printf '%s %s %s %s %s %s' "$cpu" "$cpu_temp" "$gpu_usage" "$gpu_temp" "$ram_info" "$disk_info" | jq -R -s '
  split(" ") | {cpu:.[0], cpu_temp:.[1], gpu:.[2], gpu_temp:.[3], ram:.[4], disk:.[5]}'
