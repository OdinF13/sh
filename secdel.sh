#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Usage: "${0##*/} "[file]..." >&2
  exit 1
fi

for file in "$@"; do

  if [[ ! -f "$file" ]]; then
    echo "WARNING: \"$file\" is not a file"
    continue
  fi

  shred -uzv -n 5 "$file"

done
