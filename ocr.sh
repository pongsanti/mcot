#!/bin/bash
fn_ocr() {
  #OCR=$( tesseract $1 -psm 7 stdout tess_config )
  OCR=$( tesseract $1 -psm 7 stdout )
  OCR=$( echo $OCR | sed 's/\o14//g' ) # cut out ^L character

  fn_log "Ocr:\t\t${OCR}"
  echo $OCR
}
