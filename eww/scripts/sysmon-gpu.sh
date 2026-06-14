#!/usr/bin/env bash
# System Monitor GPU data
GPU_USAGE=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null | head -1 || echo "0")
GPU_TEMP=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -1 || echo "0")
echo "{\"gpu_usage\":\"$GPU_USAGE\",\"gpu_temp\":\"$GPU_TEMP\"}"
