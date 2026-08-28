#!/usr/bin/env bash
# EWW clock widget — uses shared date-time library
set -euo pipefail

# Source shared library (installed alongside this script)
LIB_DIR="$(dirname "$0")"
source "$LIB_DIR/date-time.sh"

format_date_time "eww"