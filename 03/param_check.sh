#!/bin/bash

# Проверка на числовой параметр
param_check() {
  if [[ $1 != *[[:digit:]]* ]]; then
    echo "Error: Please enter option in digit format!"
    exit 1
  fi
  # Проверка на отсутствие параметра
  if [ -z "$1" ] # Возвращает истинное значение, если длина параметра равна 0.
  then
    echo "Error: There is no parameter found!"
    exit 1
  fi
  # Проверка на то, что параметров больше 1
  if [[ $# -gt 1 ]]
  then
    echo "Error: 1 parameters needed!"
    exit 1
  fi

  third=$(echo $1 | grep -co [[:punct:][:blank:][:cntrl:][:alpha:]])
  if [[ "$third" == "1" ]]; then
    echo "Error: Please enter option in digit format!"
    exit 1
  fi

}

date_check() {
  # Проверка на отсутствие параметра
  if [ -z "$1" ] # Возвращает истинное значение, если длина параметра равна 0.
  then
    echo "Error: There is no date found!"
    exit 1
  fi

    # Проверка на то, что параметров меньше 2
  if [[ $# -lt 2 ]]
  then
    echo "Error: 2 parameters needed: date and time!"
    exit 1
  fi
  date=$(date 2>&1 --date "$1 $2" +%d-%m-%Y\ %H:%M | awk '{print $1}' | grep -co "date")
  if [ $date -eq 1 ]; then
    echo "Error: Please enter correct date in format "YYYY-MM-DD hh:mm" (ex.: "2023-09-20 21:45")!"
    exit 1
  fi
}