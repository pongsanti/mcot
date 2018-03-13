#!/bin/bash

source ./constant
source ./util.sh
source ./cap2.sh
source ./ocr.sh
source ./db/util.sh
source ./db/config

while [ 1 ]
do
  FILE=$( fn_capture )
  CROP_FILE=$( fn_crop_filename $FILE )
  # ocr
  OCR=$( fn_ocr $CROP_FILE)
  MATCH=$( fn_match "$OCR" )

  if [ "$MATCH" != "$NOT_MATCH" ]; then
    LAST_FILE=$( fn_filename_ext $FILE )
    LAST_OCR=$OCR
  else
    if [ "$LAST_OCR" != "" ]; then
      fn_log "Put $LAST_OCR to db..."
      fn_insert "$LAST_FILE" "$LAST_OCR" 0
      fn_log "Success"
      # reset last match
      LAST_FILE=""
      LAST_OCR=""
    fi
    # remove files
    fn_remove_unmatched $FILE
  fi
  sleep 1.5
  fn_log "-------\n"
done