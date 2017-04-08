#!/bin/bash

TEMP_DIARY_FILE="temp_diary_file.txt"
TEMP_STOPWORDS_FILE="temp_stopwords_file.txt"


function ensureInputFiles {
  if [[ -z $DIARY_FILE ]]; then
    DIARY_FILE=~/diary.txt
  fi

  if [[ -z $STOPWORDS_FILE ]]; then
    STOPWORDS_FILE=stopwords.txt
  fi
}

function cleanUp {
  rm $TEMP_DIARY_FILE 2> /dev/null
  rm $TEMP_STOPWORDS_FILE 2> /dev/null
}

while getopts d:s: opt; do
  case "$opt" in
    d) echo $OPTARG > $TEMP_DIARY_FILE
      DIARY_FILE="./$TEMP_DIARY_FILE"
      ;;
    s) echo $OPTARG | tr ' ' '\n' > $TEMP_STOPWORDS_FILE
      STOPWORDS_FILE="./$TEMP_STOPWORDS_FILE"
      ;;
  esac
done

ensureInputFiles

TOP10=$(cat $DIARY_FILE | tr -c '[:alnum:]' '[\n*]'  | fgrep -vf $STOPWORDS_FILE | uniq)

# Just leaving this here as a reference - the below doesn't work correctly.
#TOP10=$(cat $DIARY_FILE | tr -c '[:alnum:]' '[\n*]' | tr -d ' ' | tr -s '[:blank:]' '\n' | fgrep -vf $STOPWORDS_FILE | sort | uniq -c | sort -nr | head  -10 | awk '{print $2}')

echo $TOP10

cleanUp
