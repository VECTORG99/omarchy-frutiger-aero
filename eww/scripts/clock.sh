#!/usr/bin/env bash
# EWW clock widget — uses shared date-time library
set -euo pipefail

# Source shared library
LIB_DIR="$(cd "$(dirname "$0")/../.." && pwd)/scripts"
source "$LIB_DIR/date-time.sh"

format_date_time "eww"