#!/bin/bash

start_time=$(date +%s)
launch_date=$(date +"%d%m%y")
launch_date_ext=$(date +"%Y-%m-%d %H:%M")
# $(date +"%d_%m_%Y_%H_%M_%S")
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
if [ $2 -gt 0 ]; then
  check_space
  names_one_gen $1 $2 $filegen_switch $4 $filename $filext $2 $6
fi

if [ $2 -gt 1 ]; then
  let max_dir_name=255-7-${#arr[*]}-1
  names_one_by_one_gen $1 $2 $filegen_switch $4 $filename $filext $2 $6
  names_pair_gen $1 $2 $filegen_switch $4 $filename $filext $2 $6
  names_three_sym_gen $1 $2 $filegen_switch $4 $filename $filext $2 $6
fi

while read line; do
  line=$(echo $line | awk '{print $1}')
  file_count=1
  names_one_by_one_gen $line $2 1 $4 $filename $filext $filename $6
  names_pair_gen $line $2 1 $4 $filename $filext $filename $6
  names_three_sym_gen $line $2 1 $4 $filename $filext $filename $6
  
done < $1/$LOG_FILE

end_time=$(date +%s)
echo Script end time = $(date +"%Y-%m-%d %H:%M:%S") | tee -a $LOG_FILE
echo "Script execution time (in seconds) = $(($end_time - $start_time))" | tee -a $LOG_FILE
exit 0