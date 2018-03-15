#!/bin/bash
fn_ocr() {
  OCR_START=`date +%s`
  #OCR=$( tesseract $1 -psm 7 stdout tess_config )
  OCR=$( tesseract $1 -psm 7 stdout )
  OCR=$( echo $OCR | sed 's/\o14//g' ) # cut out ^L character

  fn_log "Ocr:\t\t${OCR}"

  OCR_END=`date +%s`
  RUNTIME=$(($OCR_END - $OCR_START))
  fn_log "\t\t\tOCR in seconds:$RUNTIME"

  echo $OCR
}
