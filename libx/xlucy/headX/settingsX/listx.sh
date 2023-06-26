#!/bin/bash

# LIST ACTIONS
#text space
OLDIFS=$IFS
IFS=$'\n'

#bahan
locab="$(xlucy-path --locab)"

# path
inputa="$(xlucy-path --locai)"
locsa="$(xlucy-path --locsa)"

readf(){
  for i in $(ls $1);do
    cat "$1/$i"
  done
}

listaction(){
  #array input
  inputb=( $(readf $inputa) )

  #show list
  a=0
  echo "[-] DAFTAR PERINTAH LUCY :"
  for i in ${inputb[@]};do
    echo "[$a] $i"; ((a++))
  done
}

listscripts(){
  echo "[#] name file scripts actions"
  for lts in $(ls $locsa);do
    gf="${lts:2}"
    echo "[-] ${gf: -3|3}"
  done
}

# LIST PATH DIR
if [[ $1 -eq 1 ]];then
  listaction
elif [[ $1 -eq 2 ]];then
  cat $locab/pathdirx.txt
# LIST PATH FILE
elif [[ $1 -eq 3 ]];then
  cat $locab/pathfilex.txt
# LIST MODULE
elif [[ $1 -eq 4 ]];then
  cat $locab/modulex.txt
elif [[ $1 -eq 5 ]];then
  listscripts
fi

IFS=$OLDIFS
