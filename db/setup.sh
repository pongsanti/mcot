#!/bin/bash

source ./config

sqlite3 ${DB_NAME}.db <<EOS
  create table if not exists t(file text, ocr text, post boolean);
EOS

echo "Database '$DB_NAME' created."
