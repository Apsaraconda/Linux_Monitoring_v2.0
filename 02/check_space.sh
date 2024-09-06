#!/bin/bash

# Проверка на свободное место
check_space() {
  if [ $(df -h -B 1M / | tail -n 1 | awk '{printf $4}') -lt 1000 ]
  then
    echo "Free space less than 1 Gb."
    exit 1
  fi
}