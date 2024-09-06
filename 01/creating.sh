#!/bin/bash

create_dir() {
  if ! [ -e $1/$2 ]; then
    mkdir $1/$2
    if [ -d $1/$2 ]; then
      let dir_size=$(stat -c %s $1/$2)/1000
      dir_logi=$(echo $1/$2 $(date +"%Y-%m-%d %H:%M") $dir_size"kb" | tee -a $LOG_FILE)
    fi
    check_space
  else
    echo "ERROR: Directory $1/$2 exists!"
  fi
}

create_file() {
  if ! [ -e $1/$2.$3 ]; then
    head -c $4K </dev/urandom > $1/"$2.$3"
    if [ -f $1/$2.$3 ]; then
      let file_size=$(stat -c %s $1/$2.$3)/1000
      file_logi=$(echo $1/$2.$3 $(date +"%Y-%m-%d %H:%M") $file_size"kb" | tee -a $LOG_FILE)
    fi
    check_space
  elif [ -f $1/$2.$3 ]; then
    echo "ERROR: File $1/$2.$3 exists!"
  fi
}