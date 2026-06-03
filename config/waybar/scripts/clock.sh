#!/bin/bash
export LC_ALL=en_US.utf8

case ${1:-horizontal} in
  horizontal)
    d=$(date "+%A %d/%m %I:%M %p")
    echo "{\"text\": \"$d\", \"tooltip\": \"$(date)\", \"class\": \"\"}"
    ;;
  vertical)
    echo "{\"text\": \"$(date '+%A\n%d/%m\n%I:%M\n%p')\", \"tooltip\": \"$(date)\", \"class\": \"\"}"
    ;;
esac
