#!/bin/bash

fn_insert() {
  sqlite3 ${DB_PATH} <<EOS
    insert into t(file, ocr, post) values ("$1", "$2", "$3");
EOS
}