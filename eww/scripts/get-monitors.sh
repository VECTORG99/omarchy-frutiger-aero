#!/usr/bin/env bash
set -euo pipefail

# Get monitor count and names for dynamic widget placement
# Output format: JSON array of monitor objects

hyprctl -j monitors 2>/dev/null | jq -c '
  map({
    id: .id,
    name: .name,
    description: .description,
    width: .width,
    height: .height,
    x: .x,
    y: .y,
    scale: .scale,
    focused: .focused
  })'