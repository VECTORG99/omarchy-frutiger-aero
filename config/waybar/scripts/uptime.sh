#!/bin/bash
uptime=$(uptime -p | sed 's/up //; s/,//g; s/  / /g')
tooltip=$(uptime -p)
jq -n --arg t "󰥔 $uptime" --arg tt "$tooltip" '{text:$t, tooltip:$tt, class:""}'
