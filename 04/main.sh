#!/bin/bash

#               STATUS CODE SENSE
# 200 OK                    | 201 Created
# 400 Bad Request           | 401 Unauthorized
# 403 Forbidden             | 404 Not Found
# 500 Internal Server Error | 501 Not Implemented
# 502 Bad Gateway           | 503 Service Unavailable

start_time=$(date +%s)
launch_date=$(date +"%d%m%y")
launch_date_ext=$(date +"%Y-%m-%d %H:%M")
LOG_FILE="$launch_date.log"
echo Script start time = $(date +"%Y-%m-%d %H:%M:%S")

user_date="$(date +"%F %H:%M:%S")"



create_log() {
  second=0
  line_num=$RANDOM
  line_num=0   # инициализация
  while [ "$line_num" -lt 100 ]; do
    line_num=$RANDOM
    let "line_num %= 1000"
  done
  echo line_num=$line_num

  for (( i = 0; i < $line_num; i++ )); do
    ip_num1=0   # инициализация
    while [ "$ip_num1" -eq 10 ] || [ "$ip_num1" -eq 172 ] || [ "$ip_num1" -eq 192 ] || [ "$ip_num1" -eq 0 ]; do
      ip_num1=$RANDOM
      let "ip_num1 %= 254"
    done
    ip_num2=0   # инициализация
    while [ "$ip_num2" -eq 0 ]; do
      ip_num2=$RANDOM
      let "ip_num2 %= 254"
    done
    ip_num3=0   # инициализация
    while [ "$ip_num3" -eq 0 ]; do
      ip_num3=$RANDOM
      let "ip_num3 %= 254"
    done
    ip_num4=0   # инициализация
    while [ "$ip_num4" -eq 0 ]; do
      ip_num4=$RANDOM
      let "ip_num4 %= 254"
    done
    ip_line="[$ip_num1.$ip_num2.$ip_num3.$ip_num4]"

    log_date="[$(date -d "$user_date ${second}"sec"" +"%d/%b/%Y:%H:%M:%S") +0300]"

    status_code=$RANDOM
    status_code=0   # инициализация
    while [ "$status_code" -eq 0 ]; do
      status_code=$RANDOM
      let "status_code %= 10"
    done

    if [ $status_code -eq 1 ]; then
      status_code=200
    elif [ $status_code -eq 2 ]; then
      status_code=201
    elif [ $status_code -eq 3 ]; then
      status_code=400
    elif [ $status_code -eq 4 ]; then
      status_code=401
    elif [ $status_code -eq 5 ]; then
      status_code=403
    elif [ $status_code -eq 6 ]; then
      status_code=404
    elif [ $status_code -eq 7 ]; then
      status_code=500
    elif [ $status_code -eq 8 ]; then
      status_code=501
    elif [ $status_code -eq 9 ]; then
      status_code=502
    elif [ $status_code -eq 10 ]; then
      status_code=503
    fi

    declare -a http_addr
    http_addr+=("https://youtube.com")
    http_addr+=("https://vk.com")
    http_addr+=("https://google.ru")
    http_addr+=("https://vc.ru")
    http_addr+=("https://habr.com")
    http_addr+=("https://yandex.ru")
    http_addr+=("https://edu.21-school.ru")
    http_addr+=("https://stepik.org")

    http_addr_code=$RANDOM
    let "http_addr_code %= 7"

    declare -a method
    method+=("GET")
    method+=("POST")
    method+=("PUT")
    method+=("PATCH")
    method+=("DELETE")
    method_code=$RANDOM
    let "method_code %= 4"

    HTTPrequest="${method[$method_code]} /index.html HTTP/1.1"

    bytes=$RANDOM
    bytes=0   # инициализация
    while [ "$bytes" -eq 0 ]; do
      bytes=$RANDOM
    done

    declare -a Agent
    Agent+=("Mozilla")
    Agent+=("Google Chrome")
    Agent+=("Opera")
    Agent+=("Safari")
    Agent+=("Internet Explorer")
    Agent+=("Microsoft Edge")
    Agent+=("Crawler and bot")
    Agent+=("Library and net tool")
    Agent_code=$RANDOM
    let "Agent_code %= 7"

    echo "$ip_line - - $log_date \"$HTTPrequest\" $status_code $bytes \"${http_addr[$http_addr_code]}\" \"${Agent[$Agent_code]}\"">>$1
    ((second++))
  done
}

for i in 1 2 3 4 5; do
  touch log_$i.log
  user_date="$(date -d "$user_date $i day ago" +"%F %H:%M:%S")"
  create_log log_$i.log
done

end_time=$(date +%s)
echo Script end time = $(date +"%Y-%m-%d %H:%M:%S")
echo "Script execution time (in seconds) = $(($end_time - $start_time))"
exit 0