#!/bin/bash
fn_ocr() {
  OCR=$( tesseract $1 -psm 7 stdout tess_config )
  fn_log "Ocr:\t\t${OCR}"
  echo $OCR
}
