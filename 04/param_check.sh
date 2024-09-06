#!/bin/bash

date_check() {
  # Проверка на отсутствие параметра
  if [ -z "$1" ] # Возвращает истинное значение, если длина параметра равна 0.
  then
    echo "Error: There is no date found!"
    exit 1
  fi
    # Проверка на то, что параметров меньше 2
  if [[ $# -lt 1 ]]
  then
    echo "Error: 1 parameter needed!"
    exit 1
  fi
  # echo date=$1 $2
  # third=$(echo $1 | grep -co "[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]")
  # date=$(date &> /dev/null --date "$1")
  date=$(date 2>&1 --date "$1" +%d-%m-%Y | awk '{print $1}' | grep -co "date")
  # date=$(echo $(date --date="$1"  +%d/%m/%Y ))
  # echo date=$date
  if [ $date -eq 1 ]; then
    echo "Error: Please enter correct date in format "YYYY-MM-DD" (ex.: "2023-09-20")!"
    exit 1
  fi
}