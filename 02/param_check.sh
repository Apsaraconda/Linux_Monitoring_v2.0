#!/bin/bash

function Parameters_brief {
  echo "Parameter 1 is a list of English alphabet letters used in folder names (no more than 7 characters)."
  echo "Parameter 2 - the list of English alphabet letters used in the file name and extension"
  echo "(no more than 7 characters for the name, no more than 3 characters for the extension)."
  echo "Parameter 3 - file size (in Megabytes, but not more than 100)."
}

# Проверка на отсутствие параметра
if [ -z "$1" ] # Возвращает истинное значение, если длина параметра равна 0.
then
  echo "Error: There is no parameter found!"
  Parameters_brief
  echo "Try to call the script again with correct parameters."
  exit 1
fi

# Проверка на то, что параметров больше или меньше 3
if [[ $# -gt 3 ]] || [[ $# -lt 3 ]]
then
  echo "Error: 3 parameters needed!"
  Parameters_brief
  echo "Try to call the script again with correct parameters."
  exit 1

# Проверка на числовой параметр 3
elif [[ $3 != *[[:digit:]]* ]]; then
  echo "Error: Parameter 3 must have digit format!"
  exit 1
fi

third=$(echo $3 | grep -co [[:punct:][:blank:][:cntrl:][:alpha:]])
if [[ "$third" == "1" ]]; then
  echo "Error: Parameter 3 must have digit format!"
  exit 1
fi

if [[ $3 -gt 100 ]] || [[ $3 -lt 1 ]]; then
  echo "Error: Parameter 3 - file size (in Megabytes) must be in range 1-100!"
  echo "Try to call the script again with correct parameters."
  exit 1
fi


# Проверка на английские буквы
var4=$(echo $1 | grep -co [[:digit:][:punct:][:blank:][:cntrl:]])
if [[ "$var4" == "1" ]]; then
  echo "ERROR: Parameter 1 must be a list of English alphabet letters."
  exit 1
fi
var3=$(echo $2 | grep -co [[:digit:][:blank:][:cntrl:]])
if [[ "$var3" == "1" ]]; then
  echo "ERROR: Parameter 2 must be a list of English alphabet letters used in the file name and extension."
  exit 1
else
  var3=$(echo $2 | grep -co [[:punct:]])
  if [[ "$var3" == "1" ]]; then
    var3=$(echo $2 | grep -co '.')
    # echo var3=$var3
    if ! [[ "$var3" == "1" ]]; then
      echo "ERROR: Parameter 2 must be a list of English alphabet letters used in the file name and extension.\
      The delimiter is the dot character."
      exit 1
    fi
  fi
fi

# Проверка на количество символов названий папок
var1=$(echo $1 | sed s/\*//g | sed s/\$//g | grep -o [[:alpha:]])
arr=($var1)

# Обработка символов для названий файлов
var2=$(echo $2 | sed s/\*//g | sed s/\$//g | grep -o .)
arr_file=($var2)
filename=""
filenamecount=0
dotflag=0
filext=""
filextcount=0
for sym in $var2; do
  if [ $sym != '.' ] && [ $dotflag -eq 0 ]; then
    let filenamecount=$filenamecount+1
    filename=$filename$sym
  else
    if [ $sym == '.' ]; then
      let dotflag=dotflag+1
    else
      let filextcount=$filextcount+1
      filext=$filext$sym
    fi
  fi
done
var2=$(echo $filename | sed s/\*//g | sed s/\$//g | grep -o .)
arr_file=($var2)

# Проверка на символы пунктуации в имени файлов
filename_check=$(echo $filename | grep -co [[:punct:]])
if [[ "$filename_check" == "1" ]]; then
  echo "ERROR: File extension must be a list of English alphabet letters."
  exit 1
fi
# Проверка на символы пунктуации в расширении
filext_check=$(echo $filext | grep -co [[:punct:]])
if [[ "$filext_check" == "1" ]]; then
  echo "ERROR: File extension must be a list of English alphabet letters."
  exit 1
fi

if [ $dotflag -gt 1 ]; then
  echo "ERROR: Extension must have only English alphabet letters."
  exit 1
fi

# Проверка существуют ли символы для имени и расширений файлов
if [ -z "$filename" ] || [ -z "$filext" ]; then
  echo "ERROR: Parameter 3 - The list of English alphabet letters used in or extension name no found."
  exit 1
fi

if [ $filenamecount -gt 7 ]; then
  echo "ERROR: The list of English alphabet letters used in file name must be less than 7 characters."
  echo "Try to call the script again with correct parameters."
  exit 1
fi

if [ $filextcount -gt 3 ]; then
  echo "ERROR: The list of English alphabet letters used in file extension must be less than 3 characters."
  echo "Try to call the script again with correct parameters."
  exit 1
fi


if [ ${#arr[*]} -gt 7 ]; then
  echo "ERROR: The list of English alphabet letters used in folder name must be less than 7 characters."
  echo "Try to call the script again with correct parameters."
  exit 1
fi