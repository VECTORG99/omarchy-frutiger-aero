#!/bin/bash
uptime=$(uptime -p | sed 's/up //; s/,//g; s/  / /g')
tooltip=$(uptime -p)
jq -c -n --arg t "󰥔 $uptime" --arg tt "$tooltip" '{text:$t, tooltip:$tt, class:""}'
