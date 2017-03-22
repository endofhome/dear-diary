#!/bin/bash

set -e -o pipefail

if [[ -z "$DIARY_FILE" ]]; then
  DIARY_FILE=~/.diary.txt
fi

function main {
  while true; do
    echo "Who did you pair with?"
    echo "Leave blank if you worked solo and enter 'end' when you have no more entries for today."
    printf "> " && read PAIR_PARTNER
    
    if [[ $PAIR_PARTNER = "end" ]]; then
      exit 0
    fi
    
    echo "What did you do?"
    printf "> " && read DETAILS
    echo "$(date '+%A %d %B %Y'), $(partner): $DETAILS" >> $DIARY_FILE
  done
}

function partner {
  if [[ -n $PAIR_PARTNER ]]; then
    echo $(echo Paired with $(echo $PAIR_PARTNER | awk '{print toupper($0)}'))
  else
    echo "Worked solo"
  fi
}

main
