#!/bin/bash

source ./capture_config
FNAME="$(date +"%Y-%m-%dT%H:%M:%S")"
IMG_NAME="$FNAME.jpg"
CROP_FILENAME="${FNAME}_c.jpg"
echo "Filename: $IMG_NAME"
echo "Crop filename: $CROP_FILENAME"

RESIZE_ARG="${WIDTH}x${HEIGHT}"
echo "Resize arg: $RESIZE_ARG"

CROP_RES_GEO="${CROP_W}x${CROP_H}"
C_W_OFF=$((WIDTH-CROP_W))
C_H_OFF=$((HEIGHT-CROP_H))
C_H_OFF=$((C_H_OFF-BOT_OFF))
CROP_OFF_GEO="+${C_W_OFF}+${C_H_OFF}"
CROP_GEO="${CROP_RES_GEO}${CROP_OFF_GEO}"
echo "Crop arg: ${CROP_GEO}"
# capture
import -window $WINDOW_ID -resize $RESIZE_ARG $IMG_NAME
convert $IMG_NAME -crop $CROP_GEO -negate -compress none $CROP_FILENAME
# ocr
OCR="$(./ocr.sh $CROP_FILENAME)"
echo "Ocr: ${OCR}"
MATCH="$(./regex.sh "$OCR")"
if [ ! -z "$MATCH" ]; then
  echo "Found: $MATCH"
else # remove files
  rm $IMG_NAME
  rm $CROP_FILENAME
fi
