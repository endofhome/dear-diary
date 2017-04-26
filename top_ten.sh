#!/bin/bash

TEMP_DIARY_FILE="temp_diary_file.txt"
TEMP_STOPWORDS_FILE="temp_stopwords_file.txt"

function ensureInputFiles {
  if [[ -z $DIARY_FILE ]]; then
    DIARY_FILE=~/diary.txt
  fi

  STOPWORDS_FILE=stopwords.txt
}

function cleanUp {
  rm $TEMP_DIARY_FILE 2> /dev/null
  rm $TEMP_STOPWORDS_FILE 2> /dev/null
}

ensureInputFiles

while getopts d:s: opt; do
  case "$opt" in
    d) echo $OPTARG > $TEMP_DIARY_FILE
      DIARY_FILE=$TEMP_DIARY_FILE
      ;;
    s) echo $OPTARG | tr ' ' '\n' > $TEMP_STOPWORDS_FILE
      STOPWORDS_FILE=$TEMP_STOPWORDS_FILE
      ;;
  esac
done

# failed bash version...
#TOP10=$(cat $DIARY_FILE | tr -d '[:punct:]' | tr -c '[:alnum:]' '[\n*]' | sort | uniq -c | sort -nr | awk '{print $2}' | grep -Fwvf <(cat $STOPWORDS_FILE | sort) | head -10)
TOP10=$(./lib/top_ten.rb -d "$(cat $DIARY_FILE)" -s "$(cat $STOPWORDS_FILE)")

echo $TOP10

cleanUp
