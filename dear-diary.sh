#!/bin/bash

set -e -o pipefail

DIARY_FILE="diary.txt"

function main {
  echo "Dear diary... Enter 'end' if you have no more entries for today."
  while true; do
    echo "Who did you pair with?"
    printf "> " && read PAIR_PARTNER
    
    if [[ $PAIR_PARTNER = "end" ]]; then
      exit 0
    fi
    
    echo "What did you do?"
    printf "> " && read DETAILS
    echo "$(date '+%A %d %B %Y'), Paired with $(echo $PAIR_PARTNER | awk '{print toupper($0)}'): $DETAILS" >> $DIARY_FILE
  done
}

main
