#!/bin/bash

source ./constant
source ./util.sh
source ./cap2.sh
source ./ocr.sh

while [ 1 ]
do
  FILE=$( fn_capture )
  CROP_FILE=$( fn_crop_filename $FILE )
  # ocr
  OCR=$( fn_ocr $CROP_FILE)
  MATCH=$( fn_match "$OCR" )

  echo $MATCH
  if [ "$MATCH" != "$NOT_MATCH" ]; then
    fn_log "Posting $OCR..."
    # post "$OCR" &
  else # remove files
    fn_remove_unmatched $FILE
  fi
  sleep 1.5
done