#!/bin/bash
LC_ALL=en_US.UTF-8
ampm() {
  local h
  h=$(date +%H)
  if (( h < 12 )); then echo "AM"; else echo "PM"; fi
}

case ${1:-horizontal} in
  horizontal)
    d=$(date "+%A %d/%m %I:%M")
    echo "{\"text\": \"$d $(ampm)\", \"tooltip\": \"$(date)\", \"class\": \"\"}"
    ;;
  vertical)
    d=$(date "+%A")
    m=$(date "+%d/%m")
    t=$(date "+%I:%M")
    echo "{\"text\": \"${d}\n${m}\n${t}\n$(ampm)\", \"tooltip\": \"$(date)\", \"class\": \"\"}"
    ;;
esac
