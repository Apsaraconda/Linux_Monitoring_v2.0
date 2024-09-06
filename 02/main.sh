#!/bin/bash

start_time=$(date +%s)
launch_date=$(date +"%d%m%y")
launch_date_ext=$(date +"%Y-%m-%d %H:%M")
LOG_FILE="main_$launch_date.log"

# Проверки вводимых параметров
. ./param_check.sh
. ./dir_name_generator.sh
. ./check_space.sh
. ./creating.sh

echo Script start time = $(date +"%Y-%m-%d %H:%M:%S") | tee -a $LOG_FILE

let max_file_name=255-7-${#arr_file[*]}-1-$filextcount
dir_count=0
file_count=0
filegen_switch=0

RANGE=100

dir_number=$RANDOM
let "dir_number %= $RANGE"
echo "Random dir_number =  $dir_number"

file_number=$RANDOM
let "file_number %= $RANGE"
echo "Random file_number =  $file_number"
writable_dir_counter=0
declare -a paths
paths="$(find / -type d -writable -not -path "/proc*" 2>/dev/null)"
declare -a folders_listc
for path in $paths; do
  if [ $writable_dir_counter -ge $dir_number ]; then
    break
  fi
  bin_check=$(echo $path | grep -co 'bin')
  if [[ $bin_check -eq 0 ]]; then
    if [ -e $path ]; then
      let writable_dir_counter=$writable_dir_counter+1
      folders_list+=("$path")
    fi
  fi
done
if [ $dir_number -gt 0 ]; then
  check_space
  declare -a created_folders_list
  for path in ${folders_list[*]}; do
    names_one_gen $path $dir_number $filegen_switch $file_number $filename $filext $2 $3
  done
fi

if [ $dir_number -gt 1 ]; then
  let max_dir_name=255-7-${#arr[*]}-1
  for path in ${folders_list[*]}; do
    file_count=1
    dir_count=1
    names_one_by_one_gen $path $dir_number $filegen_switch $file_number $filename $filext $filename $3
    names_pair_gen $path $dir_number $filegen_switch $file_number $filename $filext $filename $3
    names_three_sym_gen $path $dir_number $filegen_switch $file_number $filename $filext $filename $3
  done
fi

for path in ${folders_list[*]}; do
  echo path=$path
  file_count=1
  file_number=$RANDOM
  let "file_number %= $RANGE"
  echo "Random file_number =  $file_number"
  names_one_by_one_gen $path $dir_number 1 $file_number $filename $filext $filename $3
  names_pair_gen $path $dir_number 1 $file_number $filename $filext $filename $3
  names_three_sym_gen $path $dir_number 1 $file_number $filename $filext $filename $3
done

end_time=$(date +%s)
echo Script end time = $(date +"%Y-%m-%d %H:%M:%S") | tee -a $LOG_FILE
echo "Script execution time (in seconds) = $(($end_time - $start_time))" | tee -a $LOG_FILE
exit 0