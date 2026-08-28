#!/usr/bin/env bash
set -euo pipefail

# Get primary monitor ID (focused or first)
# Output: monitor ID as integer

hyprctl -j monitors 2>/dev/null | jq -r '
  (map(select(.focused == true)) | .[0].id) // (.[0].id // 0)'