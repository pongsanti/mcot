#!/bin/bash

source ./constant
source ./util.sh
source ./cap2.sh
source ./ocr.sh
source ./db/util.sh
source ./db/config

fn_log "WINDOW_ID:\t$WINDOW_ID\n"

while [ 1 ]
do
  START=`date +%s`

  FILE=$( fn_capture )
  CROP_FILE=$( fn_crop_filename $FILE )

  WHITE=$( fn_all_white ${FILE_PATH}/${CROP_FILE} )
  if [ "$WHITE" -gt "85" ]; then
    fn_log "All white\tFOURCE_NOT_MATCH"
    MATCH=$NOT_MATCH
  else
    # ocr
    OCR=$( fn_ocr ${FILE_PATH}/${CROP_FILE})
    MATCH=$( fn_match "$OCR" )
  fi

  if [ "$MATCH" != "$NOT_MATCH" ]; then
    if [ "$GROUP_ID" == "" ]; then
      GROUP_ID=$( date +"%s" )
    fi

    FILE_NAME=$( fn_filename_ext $FILE )

    fn_log "Group:\t $GROUP_ID"
    fn_log "\t\tPut $LAST_OCR to db..."

    DB_START=`date +%s`
    fn_insert "$GROUP_ID" "$FILE_NAME" "$OCR"
    DB_END=`date +%s`
    RUNTIME=$(($DB_END - $DB_START))
    fn_log "\t\t\tInsert DB in seconds: $RUNTIME"

    fn_log "\t\tSuccess"
  else
    if [ "$GROUP_ID" != "" ]; then
      fn_log "Group $GROUP_ID:\t set ready"
      fn_set_ready "$GROUP_ID"
      GROUP_ID="" #reset GROUP_ID -- start new group
    fi
    # remove files
    #fn_remove_unmatched $FILE_PATH $FILE
  fi

  #sleep $SLEEP_IN_SECOND

  fn_log "-------\n"
  END=`date +%s`
  RUNTIME=$(($END - $START))
  fn_log "\t\t\t\tRuntime in seconds: $RUNTIME"
done