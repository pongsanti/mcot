#!/bin/bash

fn_insert() {
  sqlite3 ${DB_NAME}.db <<EOS
    insert into t(file, ocr, post) values ("$1", "$2", "$3");
EOS
}