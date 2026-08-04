#!/usr/bin/env bash
# System Monitor — CPU, GPU, RAM, DISK (rounded integers)
set -euo pipefail

# CPU usage
cpu=$(top -bn1 2>/dev/null | grep "Cpu(s)" | awk '{print int($2+$4)}' || echo "0")

# CPU temp
cpu_temp=$(sensors 2>/dev/null | grep -oP 'Tctl:\s+\+\K[\d.]+' | head -1 | cut -d. -f1 || echo "0")

# GPU
gpu_usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null | head -1 || echo "0")
gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -1 || echo "0")

# RAM
ram_info=$(free -m 2>/dev/null | awk '/^Mem:/ {printf "%d", ($3/$2)*100}')
[ -z "$ram_info" ] && ram_info="0"

# Disk root
disk_info=$(df / --output=pcent 2>/dev/null | tail -1 | tr -d ' %')
[ -z "$disk_info" ] && disk_info="0"

echo "$cpu $cpu_temp $gpu_usage $gpu_temp $ram_info $disk_info" | jq -R -s '
  split(" ") | {cpu:.[0], cpu_temp:.[1], gpu:.[2], gpu_temp:.[3], ram:.[4], disk:.[5]}'
