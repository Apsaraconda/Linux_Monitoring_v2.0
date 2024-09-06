#!/bin/bash

function Parameters_brief {
  echo "Parameter 1 is the absolute path."
  echo "Parameter 2 is the number of subfolders."
  echo "Parameter 3 is a list of English alphabet letters used in folder names (no more than 7 characters)."
  echo "Parameter 4 is the number of files in each created folder."
  echo "Parameter 5 - the list of English alphabet letters used in the file name and extension"
  echo "(no more than 7 characters for the name, no more than 3 characters for the extension)."
  echo "Parameter 6 - file size (in kilobytes, but not more than 100)."
}

# Проверка на отсутствие параметра
if [ -z "$1" ] # Возвращает истинное значение, если длина параметра равна 0.
then
  echo "Error: There is no parameter found!"
  Parameters_brief
  echo "Try to call the script again with correct parameters."
  exit 1
fi

# Проверка на то, что параметров больше или меньше 6
if [[ $# -gt 6 ]] || [[ $# -lt 6 ]]
then
  echo "Error: 6 parameters needed!"
  Parameters_brief
  echo "Try to call the script again with correct parameters."
  exit 1

# Проверка на числовые параметры 2, 4 и 6
elif [[ $2 != *[[:digit:]]* ]] || [[ $4 != *[[:digit:]]* ]] || [[ $6 != *[[:digit:]]* ]]
then
  echo "Error: Parameters 2, 4, 6 must have digit format!"
  Parameters_brief
  echo "Try to call the script again with correct parameters."
  exit 1

# Проверка на существование целевой папки
elif [ ! -d $1 ]
then
  echo "Error: Path is not exists!"
  exit 1
fi

second=$(echo $2 | grep -co [[:punct:][:blank:][:cntrl:][:alpha:]])
fourth=$(echo $4 | grep -co [[:punct:][:blank:][:cntrl:][:alpha:]])
sixth=$(echo $6 | grep -co [[:punct:][:blank:][:cntrl:][:alpha:]])
if [[ "$second" == "1" ]] || [[ "$fourth" == "1" ]] || [[ "$sixth" == "1" ]]; then
  echo "Error: Parameters 2, 4, 6 must have digit format!"
  Parameters_brief
  echo "Try to call the script again with correct parameters."
  exit 1
fi

if [[ $6 -gt 100 ]] || [[ $6 -lt 1 ]]; then
  echo "Error: Parameter 6 - file size (in kilobytes) must be in range 1-100!"
  echo "Try to call the script again with correct parameters."
  exit 1
fi

# Проверка на количество вложенных папок
if [[ $2 -gt 10000 ]] || [[ $2 -lt 0 ]] || [[ $4 -gt 10000 ]] || [[ $4 -lt 0 ]]; then
  echo "Error: Parameters 2 & 4 - must be in range 0-10000!"
  echo "Try to call the script again with correct parameters."
  exit 1
fi


# Проверка на английские буквы
var4=$(echo $3 | grep -co [[:digit:][:punct:][:blank:][:cntrl:]])
if [[ "$var4" == "1" ]]; then
  echo "ERROR: Parameter 3 must be a list of English alphabet letters."
  exit 1
fi
var3=$(echo $5 | grep -co [[:digit:][:blank:][:cntrl:]])
if [[ "$var3" == "1" ]]; then
  echo "ERROR: Parameter 5 must be a list of English alphabet letters used in the file name and extension."
  exit 1
else
  var3=$(echo $5 | grep -co [[:punct:]])
  if [[ "$var3" == "1" ]]; then
    var3=$(echo $5 | grep -co '.')
    if ! [[ "$var3" == "1" ]]; then
      echo "ERROR: Parameter 5 must be a list of English alphabet letters used in the file name and extension.\
      The delimiter is the dot character."
      exit 1
    fi
  fi
fi

# Проверка на количество символов названий папок
var1=$(echo $3 | sed s/\*//g | sed s/\$//g | grep -o [[:alpha:]])
arr=($var1)

# Обработка символов для названий файлов
var2=$(echo $5 | sed s/\*//g | sed s/\$//g | grep -o .)
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
  echo "ERROR: Parameter 5 - The list of English alphabet letters used in or extension name no found."
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

# Проверка на абсолютный путь
if ! [[ $1 == /* ]] ; then
  echo "Error: Invalid syntax"
  echo "The parameter 1 must be an absolute path to a directory."
  echo "Try to call the script again with correct parameters."
  exit 1
fi