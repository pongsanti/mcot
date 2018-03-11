#!/bin/bash

source ./capture_config
source ./regex.sh

fn_capture()
{
  FNAME="$(date +"%Y-%m-%dT%H:%M:%S")"
  IMG_NAME="$FNAME.jpg"
  CROP_FILENAME="${FNAME}_c.jpg"
  echo -e "Filename:\t$IMG_NAME"
  echo -e "Crop filename:\t$CROP_FILENAME"

  RESIZE_ARG="${WIDTH}x${HEIGHT}"
  echo -e "Resize arg:\t$RESIZE_ARG"

  CROP_RES_GEO="${CROP_W}x${CROP_H}"
  C_W_OFF=$((WIDTH-CROP_W))
  C_H_OFF=$((HEIGHT-CROP_H))
  C_H_OFF=$((C_H_OFF-BOT_OFF))
  CROP_OFF_GEO="+${C_W_OFF}+${C_H_OFF}"
  CROP_GEO="${CROP_RES_GEO}${CROP_OFF_GEO}"
  echo -e "Crop arg:\t${CROP_GEO}"
  # capture
  import -window $WINDOW_ID -resize $RESIZE_ARG $IMG_NAME
  convert $IMG_NAME -crop $CROP_GEO -colorspace gray -lat 25x25+5% -compress none $CROP_FILENAME
  # ocr
  OCR="$(./ocr.sh $CROP_FILENAME)"
  echo -e "Ocr:\t\t${OCR}"

  fn_match "$OCR"
  MATCH_RET_CODE=$?
  if [ "$MATCH_RET_CODE" -ne "0" ]; then
    return $MATCH_RET_CODE
  else # remove files
    rm $IMG_NAME
    rm $CROP_FILENAME
    return 0
  fi
}
