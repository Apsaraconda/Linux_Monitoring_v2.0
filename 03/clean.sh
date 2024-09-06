#!/bin/bash

start_time=$(date +%s)

. ./param_check.sh

echo "Choose cleaning method:"
echo "1 - By log file"
echo "2 - By creation date and time"
echo "3 - By name mask (i.e. characters, underlining and date)."
read answer
param_check $answer

if [[ $answer == 1 ]]; then
  echo "Enter absolute or relative path to a log file."
  read path
  if ! [[ $path == /* ]] && ! [[ $path == ./* ]] && ! [[ $path == ../* ]]; then
		echo "Error: Invalid syntax"
		echo "The parameter must be an absolute or relative path to a log file."
    exit 1
	elif [ ! -f "$path" ]; then   # Кавычки необходимы на тот случай, если имя файла содержит пробелы.
    echo "File $path not found!"
    exit 1
	elif [ ${path##*.} != "log" ]; then   # Квадратные скобки нужны для выполнения подстановки значения переменной
    echo "File $path is not .log file!"
    exit 1
  else
  echo Script start time = $(date +"%H:%M:%S %d_%m_%y")
		while read line; do
      if [ $(echo $line | grep -c '^/') -eq 1 ]; then
        # echo $line
        rm -rf $line
      fi
    done < $path
    rm -rf $path
		end_time=$(date +%s)
    echo Script end time = $(date +"%H:%M:%S %d_%m_%y")
		echo "Script execution time (in seconds) = $(($end_time - $start_time))"
	fi
elif [[ $answer == 2 ]]; then
  echo "Please enter older date in format "YYYY-MM-DD hh:mm" (ex.: "2023-09-20 21:45")"
  read first_date first_time
  date_check $first_date $first_time
  echo "Please enter newer date in format "YYYY-MM-DD hh:mm" (ex.: "2023-09-20 21:45")"
  read second_date second_time
  date_check $second_date $second_time
  files="$(find / -regex '.*/.*_[0-9][0-9][0-9][0-9][0-9][0-9]\(\..*\)?$' -newerct "$first_date $first_time" ! -newerct "$second_date $second_time" 2>/dev/null)"
  for file in $files; do
    echo found $file
  done
  echo "Are you sure to delete the files?"
  echo "(Y/N):"
  read answer
  if [[ $answer = "y" || $answer = "Y" ]]; then
    for file in $files; do
    echo removing $file
    rm -rf $file
    done
  fi
elif [[ $answer == 3 ]]; then
  echo "Please enter the number of days older than which need to search"
  read time
  param_check $time
  declare -a files
  files="$(find / -regex '.*/.*_[0-9][0-9][0-9][0-9][0-9][0-9]\(\..*\)?$' -mtime -$time 2>/dev/null)"
  for file in $files; do
    echo found $file
  done
  echo "Are you sure to delete the files?"
  echo "(Y/N):"
  read answer
  if [[ $answer = "y" || $answer = "Y" ]]; then
    for file in $files; do
    echo removing $file
    rm -rf $file
    done
  fi
else
  echo Enter correct parameter!
fi
