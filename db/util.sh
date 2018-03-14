#!/bin/bash

fn_insert() {
  sqlite3 ${DB_PATH} <<EOS
    insert into ts(gid, file, ocr, ready, post) values ("$1", "$2", "$3", 0, 0);
EOS
}

fn_set_ready() {
  sqlite3 ${DB_PATH} <<EOS
    update ts set ready = 1 where gid ="$1";
EOS
}