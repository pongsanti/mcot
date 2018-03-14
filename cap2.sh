#!/bin/bash

source ./capture_config
source ./regex.sh
source ./post.sh

fn_capture()
{
  FNAME=$( fn_filename )
  IMG_NAME="$FNAME.jpg"
  CROP_FILENAME=$( fn_crop_filename $FNAME )
  fn_log "Filename:\t$IMG_NAME"
  fn_log "Crop filename:\t$CROP_FILENAME"

  RESIZE_ARG="${WIDTH}x${HEIGHT}"
  fn_log "Resize arg:\t$RESIZE_ARG"

  CROP_RES_GEO="${CROP_W}x${CROP_H}"
  C_W_OFF=$((WIDTH-CROP_W))
  C_H_OFF=$((HEIGHT-CROP_H))
  C_H_OFF=$((C_H_OFF-BOT_OFF))
  CROP_OFF_GEO="+${C_W_OFF}+${C_H_OFF}"
  CROP_GEO="${CROP_RES_GEO}${CROP_OFF_GEO}"
  fn_log "Crop arg:\t${CROP_GEO}"
  # capture
  import -window $WINDOW_ID -resize $RESIZE_ARG ${FILE_PATH}/${IMG_NAME}
  convert ${FILE_PATH}/${IMG_NAME} -crop $CROP_GEO -colorspace gray -lat 10x10+5% -negate ${FILE_PATH}/${CROP_FILENAME}

  echo $FNAME
}
