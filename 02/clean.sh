#!/bin/bash

start_time=$(date +%s)

if [ $# -ne 1 ]; then
	echo "Error: The script is run with a single parameter"
  exit 1
else
	if ! [[ $1 == /* ]] && ! [[ $1 == ./* ]] ; then
		echo "Error: Invalid syntax"
		echo "The parameter must be an absolute or relative path to a directory."
    exit 1
	elif [ ! -f "$1" ]; then   # Кавычки необходимы на тот случай, если имя файла содержит пробелы.
    echo "File $1 not found!"
    exit 1
	elif [ ${1##*.} != "log" ]; then   # Квадратные скобки нужны для выполнения подстановки значения переменной
    echo "File $1 is not .log file!"
    exit 1
  else
  echo Script start time = $(date +"%Y-%m-%d %H:%M:%S")
		while read line; do
      if [ $(echo $line | awk '{print $1}' | grep -c '^/') -eq 1 ]; then
        rm -rf $line
      fi
    done < $1
    rm -rf $1
		end_time=$(date +%s)
    echo Script end time = $(date +"%Y-%m-%d %H:%M:%S")
		echo "Script execution time (in seconds) = $(($end_time - $start_time))"
	fi
fi