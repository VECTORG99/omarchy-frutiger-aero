#!/usr/bin/env bash
set -euo pipefail

EWW_CMD="$(command -v eww || echo "$HOME/.local/bin/eww")"
"$EWW_CMD" active-windows 2>/dev/null | grep -qw "^${1:-}" && echo "on" || echo "off"
