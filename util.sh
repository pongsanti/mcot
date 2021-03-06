#!/bin/bash

fn_filename() {
  echo "$(date +"%Y-%m-%dt%T")"
}

fn_filename_ext() {
  echo "$1.jpg"
}

fn_crop_filename() {
  echo "$1_c.jpg"
}

fn_log() {
  echo -e >&2 $1
}

fn_log_to_file() {
  echo -e $1 >> log.txt
}

fn_remove_unmatched() {
  CROP_FILE=$( fn_crop_filename $2 )
  rm $1/$2.jpg
  rm $1/$CROP_FILE
}

fn_all_white() {
  PERCENT=$( convert "$1"  -threshold 65534 -format "%[fx:100*image.mean]" info: )
  fn_log "white % = $PERCENT"
  echo $( printf '%.*f\n' 0 $PERCENT )
}
