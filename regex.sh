#!/bin/bash

source ./constant

fn_match()
{
  if [[ "$1" =~ $SET_REGEX ]]; then
    fn_log "\tfound SET!"
    fn_log_to_file "$(date) $1"
    echo SET
  elif [[ "$1" =~ $SET50_REGEX ]]; then
    fn_log "\tfound SET50!"
    fn_log_to_file "$(date) $1"
    echo SET50
  else
    echo NOT_MATCH
  fi
}
