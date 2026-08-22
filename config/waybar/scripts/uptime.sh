#!/bin/bash
set -euo pipefail
uptime=$(uptime -p | sed 's/up //; s/,//g; s/  / /g')
tooltip=$(uptime -p)
jq -nc --arg t "󰥔 $uptime" --arg tt "$tooltip" '{text:$t, tooltip:$tt, class:""}'
