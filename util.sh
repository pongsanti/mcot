#!/bin/bash

fn_filename() {
  echo "$(date +"%Y-%m-%dt%Ts%s")"
}

fn_log() {
  echo -e $1
}
