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
  CROP_FILE=$( fn_crop_filename $1 )
  rm ${1}.jpg
  rm $CROP_FILE
}
