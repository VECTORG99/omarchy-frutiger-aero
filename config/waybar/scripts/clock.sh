#!/bin/bash
export LC_ALL=en_US.utf8

case ${1:-horizontal} in
  horizontal)
    d=$(date "+%A %d/%m %I:%M %p")
    tooltip=$(date)
    jq -nc --arg t "$d" --arg tt "$tooltip" '{text:$t, tooltip:$tt, class:""}'
    ;;
  vertical)
    d=$(date '+%A\n%d/%m\n%I:%M\n%p')
    tooltip=$(date)
    jq -nc --arg t "$d" --arg tt "$tooltip" '{text:$t, tooltip:$tt, class:""}'
    ;;
esac
