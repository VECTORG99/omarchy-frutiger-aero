#!/bin/bash
# System Monitor — CPU, GPU, RAM, DISK (rounded integers)
# Optimized: reads /proc/stat directly instead of top (223ms → <1ms)
set -euo pipefail

# CPU usage — read /proc/stat twice with 100ms sleep, compute delta
# /proc/stat line 1: cpu user nice system idle iowait irq softirq steal guest guest_nice
read_cpu_jiffies() {
  awk '/^cpu / {print $2+$3+$4+$5+$6+$7+$8, $5}' /proc/stat
}
read -r total1 idle1 <<< "$(read_cpu_jiffies)"
sleep 0.1
read -r total2 idle2 <<< "$(read_cpu_jiffies)"
total_diff=$(( total2 - total1 ))
idle_diff=$(( idle2 - idle1 ))
if [ "$total_diff" -gt 0 ]; then
  cpu=$(( (total_diff - idle_diff) * 100 / total_diff ))
else
  cpu=0
fi
[ "$cpu" -lt 0 ] && cpu=0
[ "$cpu" -gt 100 ] && cpu=100

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
ram_total=$(free -g 2>/dev/null | awk '/^Mem:/ {printf "%d", $2}')
[ -z "$ram_total" ] && ram_total="0"

# Disk root
disk_info=$(df / --output=pcent 2>/dev/null | tail -1 | tr -d ' %')
[ -z "$disk_info" ] && disk_info="0"
disk_total=$(df / --output=size -B1 2>/dev/null | tail -1 | awk '{printf "%.0f", $1/1024/1024/1024}')
[ -z "$disk_total" ] && disk_total="0"

printf '%s %s %s %s %s %s %s %s' "$cpu" "$cpu_temp" "$gpu_usage" "$gpu_temp" "$ram_info" "$ram_total" "$disk_info" "$disk_total" | jq -R -s '
  split(" ") | {cpu:.[0], cpu_temp:.[1], gpu:.[2], gpu_temp:.[3], ram:.[4], ram_total:.[5], disk:.[6], disk_total:.[7]}'
