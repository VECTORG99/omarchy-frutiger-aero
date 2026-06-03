#!/bin/bash
uptime=$(uptime -p | sed 's/up //; s/,//g; s/  / /g')
echo "{\"text\": \"󰥔 $uptime\", \"tooltip\": \"$(uptime -p)\", \"class\": \"\"}"
