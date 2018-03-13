#!/bin/bash

source ./config

echo -e "Database path: \t${DB_PATH}"

sqlite3 ${DB_PATH} <<EOS
  create table if not exists ts(file text, ocr text, normalized text, post boolean);
EOS

echo "Database '$DB_NAME' created."
