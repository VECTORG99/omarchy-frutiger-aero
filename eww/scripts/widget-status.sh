#!/bin/bash
CMD="$HOME/.local/bin/eww"
$CMD active-windows 2>/dev/null | grep -qw "^${1:-}" && echo "on" || echo "off"
