#!/bin/bash


# $1 - это абсолютный путь.
# $2 - количество вложенных папок
# $3 - переключатель режима: 0 - генерации папок, 1 - генерации файлов
# $4 - количество файлов, которое нужно создать
# $5 - буквы для имени файлов
# $6 - буквы для имени расширений
# $7 - название сгенерированной папки
# $8 - размер файлов в килобайтах
names_one_gen() {
  dir_name_temp=""
  index1=0
  if [ $3 == 0 ];then
    array=($var1)
  else
    array=($var2)
  fi
  for char in ${array[*]}; do
    dir_name_temp=$dir_name_temp$char
    if [ ${#array[*]} -lt 5 ]; then
      let last_index=${#array[*]}-1
        if [ $index1 -eq $last_index ]; then
          let arr_dif=5-${#array[*]}
          while [ $arr_dif -gt 0 ]; do
            dir_name_temp=$dir_name_temp$char
            let arr_dif=$arr_dif-1
          done
        fi
    fi
    let index1=$index1+1
  done
  name_temp=$dir_name_temp
  dir_name_temp=$dir_name_temp\_$launch_date
  if [ $3 == 0 ];then
    dir_name1=$dir_name_temp
    create_dir $1 $dir_name1
    dir_count=1
    if [ $4 -gt 0 ]; then
      names_one_gen $1 $2 1 $4 $filename $filext $dir_name1 $8
    fi
  else
    file_name1=$dir_name_temp
    create_file $1/$7 $file_name1 $filext $8
    file_count=1
  fi
}

# $1 - это абсолютный путь.
# $2 - количество вложенных папок.
# $3 - переключатель режима: 0 - генерации папок, 1 - генерации файлов
# $4 - количество файлов, которое нужно создать
# $5 - буквы для имени файлов
# $6 - буквы для имени расширений
# $7 - название сгенерированной папки
# $8 - размер файлов в килобайтах
names_one_by_one_gen() {
  if [ -e $1 ]; then
    if ! [ -f $1 ]; then
      max_name=0
      max_quantity=0
      count=0
      max_index=0
      if [ $3 == 0 ];then
        max_name=$max_dir_name
        max_quantity=$2
        count=$dir_count
        max_index=${#arr[*]}
        var_temp=$var1
        array_src=($var1)
      else
        max_name=$max_file_name
        max_quantity=$4
        count=$file_count
        max_index=$filenamecount
        var_temp=$(echo $5 | sed s/\*//g | sed s/\$//g | grep -o .)
        array_src=($var2)
      fi
      index2=0
      while [ $count -lt $max_quantity ] && [ $index2 -lt $max_index ]; do
        char_count=0
        arr_temp=($var_temp)  #
        dir_name_temp=""  #
        while [ $char_count -lt $max_name ] && [ $count -lt $max_quantity ]; do
          arr_temp[$index2]=$(echo ${arr_temp[$index2]} | sed s/${array_src[$index2]}/${array_src[$index2]}${array_src[$index]}/)
          let char_count=$char_count+1
          let count=$count+1
          dir_name_temp=""  #
          for char in ${arr_temp[*]}; do  #
            dir_name_temp=$dir_name_temp$char  #
          done  #
          dir_name_temp=$dir_name_temp\_$launch_date  #
          if [ $3 == 0 ]; then
            dir_name2=$dir_name_temp
            create_dir $1 $dir_name2
            if [ $4 -gt 0 ]; then
              names_one_gen $1 $2 1 $4 $filename $filext $dir_name2 $8
            fi
          else
            file_name2=$dir_name_temp
            create_file $1 $file_name2 $filext $8
          fi
        done
        let index2=$index2+1
        arr_temp=($var_temp)  #
      done
    fi
  fi
}

# 
names_pair_gen() {
  if [ -e $1 ]; then
    if ! [ -f $1 ]; then
      max_name=0
      max_quantity=0
      count=0
      max_index=0
      if [ $3 == 0 ];then
        let max_name=$max_dir_name-2
        max_quantity=$2
        count=$dir_count
        max_index=${#arr[*]}
        var_temp=$var1
        array_src=($var1)
      else
        let max_name=$max_file_name-2
        max_quantity=$4
        count=$file_count
        max_index=$filenamecount
        var_temp=$(echo $5 | sed s/\*//g | sed s/\$//g | grep -o .)
        array_src=($var2)
      fi
      pairs_parameter=1
      while [ $pairs_parameter -lt $max_index ] && [ $count -lt $max_quantity ]; do
        let index3=0
        let max_pairs=$max_index-$pairs_parameter  # 1 param
        arr_temp=($var_temp)  #
        dir_name_temp=""  #
        while [ $index3 -lt $max_pairs ] && [ $count -lt $max_quantity ]; do
          let char_count=0
          while [ $char_count -lt $max_name ] && [ $count -lt $max_quantity ]; do
            arr_temp[$index3]=$(echo ${arr_temp[$index3]} | sed s/${array_src[$index3]}/${array_src[$index3]}${array_src[$index3]}/)
            let index3=$index3+$pairs_parameter  # 2 param
            arr_temp[$index3]=$(echo ${arr_temp[$index3]} | sed s/${array_src[$index3]}/${array_src[$index3]}${array_src[$index3]}/)
            let index3=$index3-$pairs_parameter  # 3 param
            let count=$count+1
            let char_count=$char_count+2
            dir_name_temp=""  #
            for char in ${arr_temp[*]}; do  #
              dir_name_temp=$dir_name_temp$char  #
            done  #
            dir_name_temp=$dir_name_temp\_$launch_date  #
            if [ $3 == 0 ]; then
              dir_name3=$dir_name_temp
              create_dir $1 $dir_name3
              let dir_count=$dir_count+1
              if [ $4 -gt 0 ]; then
                names_one_gen $1 $2 1 $4 $filename $filext $dir_name3 $8
              fi
            else
              file_name3=$dir_name_temp
              create_file $1 $file_name3 $filext $8
              let file_count=$file_count+1
            fi
          done
          arr_temp=($var_temp)  #
          let index3=$index3+1
        done
      let pairs_parameter=$pairs_parameter+1
      done
    fi
  fi
}

#  Функция для порядка символов abcdefg по очередности удваивает по три символа
#  shift_combs обозначает варианты ab* ac* ad* ae* af* 
#  где * - это последовательно следующие за вариантом символы, за которые отвечает переменная iter
#  iter обозначает варианты abс abd ade и так далее
#  1 param = $iter+1 представляет собой число возможных вариантов для заданного shift_combs
#  2 param = $shift_combs это на сколько сдвигаемся по индексу для выбора второго символа
#  3 param = $iter это на сколько сдвигаемся по индексу для выбора третьего символа
#  4 param = $iter+1 - возвращает к индексу первого символа
# $1 - это абсолютный путь.
# $2 - количество вложенных папок.
# $3 - переключатель режима: 0 - генерации папок, 1 - генерации файлов
# $4 - количество файлов, которое нужно создать
# $5 - буквы для имени файлов
# $6 - буквы для имени расширений
# $7 - название сгенерированной папки
# $8 - размер файлов в килобайтах
names_three_sym_gen() {
  if [ -e $1 ]; then
    if ! [ -f $1 ]; then
      max_name=0
      max_quantity=0
      count=0
      max_index=0
      if [ $3 == 0 ];then
        let max_name=$max_dir_name-3
        max_quantity=$2
        count=$dir_count
        max_index=${#arr[*]}
        var_temp=$var1
        array_src=($var1)
      else
        let max_name=$max_file_name-3
        max_quantity=$4
        count=$file_count
        max_index=$filenamecount
        var_temp=$(echo $5 | sed s/\*//g | sed s/\$//g | grep -o .)
        array_src=($var2)
      fi
      shift_combs=1
      let iter_combinations=$max_index-1
      while [ $shift_combs -lt $iter_combinations ] && [ $count -lt $max_quantity ];do
        iter=$shift_combs
        while [ $iter -lt $iter_combinations ] && [ $count -lt $max_quantity ];do
          arr_temp=($var_temp)  #
          dir_name_temp=""  #
          let index4=0
          let max_three_pairs=$max_index-$iter-1  # 1 param = $iter+1
          while [ $index4 -lt $max_three_pairs ] && [ $count -lt $max_quantity ]; do
            let char_count=0
            while [ $char_count -lt $max_name ] && [ $count -lt $max_quantity ]; do
              arr_temp[$index4]=$(echo ${arr_temp[$index4]} | sed s/${array_src[$index4]}/${array_src[$index4]}${array_src[$index4]}/)
              let index4=$index4+$shift_combs  # 2 param = $shift_combs
              arr_temp[$index4]=$(echo ${arr_temp[$index4]} | sed s/${array_src[$index4]}/${array_src[$index4]}${array_src[$index4]}/)
              let index4=$index4+$iter+1-$shift_combs  # 3 param = $iter 
              arr_temp[$index4]=$(echo ${arr_temp[$index4]} | sed s/${array_src[$index4]}/${array_src[$index4]}${array_src[$index4]}/)
              let index4=$index4-$iter-1  # 4 param = $iter+1
              let count=$count+1
              let char_count=$char_count+3
              dir_name_temp=""  #
              for char in ${arr_temp[*]}; do  #
                dir_name_temp=$dir_name_temp$char  #
              done  #
              dir_name_temp=$dir_name_temp\_$launch_date  #
              if [ $3 == 0 ]; then
                dir_name4=$dir_name_temp
                create_dir $1 $dir_name4
                let dir_count=$dir_count+1
                if [ $4 -gt 0 ]; then
                  names_one_gen $1 $2 1 $4 $filename $filext $dir_name4 $8
                fi
              else
                file_name4=$dir_name_temp
                create_file $1 $file_name4 $filext $8
                let file_count=$file_count+1
              fi
            done
            arr_temp=($var_temp)  #
            let index4=$index4+1
          done
          let iter=$iter+1
        done
        let shift_combs=$shift_combs+1
      done
    fi
  fi
}