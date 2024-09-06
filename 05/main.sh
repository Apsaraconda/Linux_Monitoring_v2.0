#! /bin/bash

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
parameter=$(echo $1 | grep -co [[:punct:][:blank:][:cntrl:][:alpha:]])
if [[ "$parameter" == "1" ]]; then
  echo "Error: Please enter parameter in digit format!"
  exit 1
fi

if [[ $1 -eq 1 ]]; then
  cat ../04/log_*.log | sort -k9
  cat ../04/log_*.log | sort -k9 > sort_by_code.log
elif [[ $1 -eq 2 ]]; then
  cat ../04/log_*.log | awk '{print $1}' | uniq -u
  cat ../04/log_*.log | awk '{print $1}' | uniq -u > uniq_ip.log
elif [[ $1 -eq 3 ]]; then
  cat ../04/log_*.log | grep -e "[ ][45][0-9][0-9][ ][0-9]"
  cat ../04/log_*.log | grep -e "[ ][45][0-9][0-9][ ][0-9]" > error_code.log
elif [[ $1 -eq 4 ]]; then
  cat ../04/log_*.log | grep -e "[ ][45][0-9][0-9][ ][0-9]" | awk '{print $1}' | uniq -u
  cat ../04/log_*.log | grep -e "[ ][45][0-9][0-9][ ][0-9]" | awk '{print $1}' | uniq -u > uniq_error_ip.log
else
  echo "Error: Parameter must be in range of 1-4!"
fi