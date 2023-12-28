#!/bin/bash

# data
akar="$(xlucy-path --locr)"
data1=$1
data2=$2
data3=$3

# input data in array
declare -a svfile
declare -a gfolder
declare -a skipdir
declare -a arrcari

# permission
izinr(){
  if ! [ -r $1 ];then
    echo "[!] path <$1> tidak ada izin read(r)"; exit
  fi
}

# scan directory
scanfile(){
  for scan in $(ls);do
    # scan all file in folder
    if [[ $1 -eq 3 ]];then
      if [ -d $scan ];then
        echo "[d] $(pwd)/$scan"
      elif [ -f $scan ];then
        echo "[f] $(pwd)/$scan"
      fi
    fi
    # lewati folder ke folder
    for skips in ${skipdir[@]};do
      if [ -d $skips ] && [[ $skips == $scan ]];then continue 2; fi
    done
    # temukan file
    for scanb in ${arrcari[@]};do
      if [[ $scanb == $scan ]];then
        if [ -d $scan ];then echo "[d] $(pwd)/$scan"
        elif [ -f $scan ];then echo "[f] $(pwd)/$scan"
        fi
      fi
    done
    # scan folder ke folder
    if [ -d $scan ];then
      if ! [ -r $scan ];then idx=${#skipdir[@]}
        skipdir[$idx]=$scan; continue
      fi
      cd $scan
      # scan all folder or not
      if [[ $1 -eq 3 ]];then
        scanfile 3
      else
        scanfile
      fi
      cd ..
    fi
  done
}

# scan many file
carib(){
  idx=0; iarr=0; jchar=$(expr length $1)
  if [[ $2 -eq 1 ]];then
    tchar=${1:0}
  elif [[ $2 -eq 2 ]];then
    tchar=${1:2}
  fi
  while [[ $idx -le $jchar ]];do
    char1=${tchar:idx:1}
    if [[ $char1 != "[" ]] && [[ $char1 != "," ]] && [[ $char1 != "]" ]];then
      var+=$char1
    fi
    # tampung banyak file di array
    if [[ $char1 == "," ]] || [[ $char1 == "]" ]];then
      if [[ $2 -eq 1 ]];then
        arrcari[$iarr]=$var
      elif [[ $2 -eq 2 ]];then
        skipdir[$iarr]=$var
      fi
      unset var; ((iarr++))
    fi
    ((idx++))
  done
}

# scan char
scanchar(){
  sfile=$1; jchar=$2
  # pindai char
  for scan in $(ls);do
    # lewati folder ke folder
    for skips in ${skipdir[@]};do
      if [ -d $skips ] && [[ $skips == $scan ]];then
        # echo "[!] directory skip : $skips"
        continue 2
      fi
    done
    # temukan file dengan char
    gchar=${scan:0:jchar}
    if [[ $sfile == $gchar ]];then
      if [ -d $scan ];then
        echo "[d] $(pwd)/$scan"
      elif [ -f $scan ];then
        echo "[f] $(pwd)/$scan"
      fi
    fi
    # cari char folder ke folder
    if [ -d $scan ];then
      if ! [ -r $scan ];then idx=${#skipdir[@]}
        skipdir[$idx]=$scan; continue
      fi
      cd $scan; scanchar $1 $2; cd ..
    fi
  done
}

# check input
foundfile(){
  if [[ $2 == "-s[" ]] && [[ $3 == "]" ]] && [[ $4 -eq 2 ]];then
    carib $1 2
  elif [[ $2 == "[" ]] && [[ $3 == "]" ]] && [[ $4 -eq 1 ]];then
    carib $1 1; scanfile
  else
    scanchar $1 "$(expr length $1)"
  fi
}

# starting
# get char data
chara=${data1:0:1}
charak=${data1: -1}
charas2=${data2:0:3}
charaks2=${data2: -1}
charas3=${data3:0:3}
charaks3=${data3: -1}

# check parameter
if [ $data1 ] && [ -z $data2 ];then cd $akar
  foundfile $data1 $chara $charak 1
elif [ $data1 ] && ! [ -d $data2 ];then cd $akar
  if ! [ -d $data2 ] || [[ $charas2 != "-s[" ]] && [[ $charaks2 != "]" ]];then
    echo "[!] try < xlucy -f file /path/path > for found file"
    echo "[!] try < xlucy -f [file,file] -s[dir,dir] for skip directory"; exit
  fi
  foundfile $data2 $charas2 $charaks2 2
  foundfile $data1 $chara $charak 1
elif [ $data1 ] && [ -d $data2 ] && [ -z $data3 ];then cd $data2
  foundfile $data1 $chara $charak 1
elif [ $data1 ] && [ -d $data2 ] && [ $data3 ];then cd $data2
  if [[ $charas3 != "-s[" ]] && [[ $charaks3 != "]" ]];then
    echo "[!] try < xlucy -f [file,file] /path/path -s[dir,dir] > for skip directory"; exit
  fi
  foundfile $data3 $charas3 $charaks3 2
  foundfile $data1 $chara $charak 1
fi

# stalkersx
