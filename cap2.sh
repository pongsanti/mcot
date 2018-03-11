#!/bin/bash

. ./capture_config
FNAME="$(date +"%s")"
IMG_NAME="$FNAME.jpg"
echo "Filename: $IMG_NAME"

RESIZE_ARG="${WIDTH}x${HEIGHT}"
echo "Resize arg: $RESIZE_ARG"

CROP_RES_GEO="${CROP_W}x${CROP_H}"
C_W_OFF=$((WIDTH-CROP_W))
C_H_OFF=$((HEIGHT-CROP_H))
C_H_OFF=$((C_H_OFF-BOT_OFF))
CROP_OFF_GEO="+${C_W_OFF}+${C_H_OFF}"
CROP_GEO="${CROP_RES_GEO}${CROP_OFF_GEO}"
echo "Crop arg: ${CROP_GEO}"

import -window $WINDOW_ID -resize $RESIZE_ARG -negate $IMG_NAME
convert $IMG_NAME -crop $CROP_GEO -compress none $IMG_NAME
# convert $IMG_NAME -negate -compress none $IMG_NAME
