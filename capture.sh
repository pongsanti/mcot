#!/bin/bash

#import -window root -resize 1280x768 -delay 200 $(date +"%s")
FNAME="$(date +"%s")"
IMG_NAME="$FNAME.jpg"
WINDOW_ID=${1:-root}

WIDTH=${2:-1280}
HEIGHT=${3:-720}

CROP_W=${4:-390}
CROP_H=${5:-40}
CROP_RES_GEO="${CROP_W}x${CROP_H}"

C_W_OFF=$((WIDTH-CROP_W))
C_H_OFF=$((HEIGHT-CROP_H))
BOT_OFF=${6:-25}
C_H_OFF=$((C_H_OFF-BOT_OFF))

CROP_OFF_GEO="+${C_W_OFF}+${C_H_OFF}"

CROP_GEO="${CROP_RES_GEO}${CROP_OFF_GEO}"
echo ${CROP_GEO}

import -window $WINDOW_ID -resize "${WIDTH}x${HEIGHT}" -negate $IMG_NAME
convert $IMG_NAME -crop $CROP_GEO -compress none $IMG_NAME
# convert $IMG_NAME -negate -compress none $IMG_NAME
