#!/usr/bin/env bash
# Waybar clock module — uses shared date-time library
set -euo pipefail

# Source shared library (installed alongside this script)
LIB_DIR="$(dirname "$0")"
source "$LIB_DIR/date-time.sh"

format="${1:-horizontal}"

text=$(format_date_time "$format")
tooltip=$(get_tooltip)

jq -nc --arg t "$text" --arg tt "$tooltip" '{text:$t, tooltip:$tt, class:""}'