#!/bin/bash

source ./util.sh
source ./cap2.sh

while [ 1 ]
do
  fn_capture
  CAP_RET_CODE=$?
  echo "Match code: $CAP_RET_CODE"
  echo -e "-----\r\n"
  # if [ "$CAP_RET_CODE" -eq "2" ]; then #SET100
    # echo "sleeping for 8 seconds"
    # sleep 8
  # else
    # echo "sleeping for 2 seconds"
    # sleep 2
  # fi
  sleep 1.5
done