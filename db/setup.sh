#!/bin/bash

source ./config

echo -e "Database path: \t${DB_PATH}"

sqlite3 ${DB_PATH} <<EOS
  create table if not exists t(file text, ocr text, post boolean);
EOS

echo "Database '$DB_NAME' created."
