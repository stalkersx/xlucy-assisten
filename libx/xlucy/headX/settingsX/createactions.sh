#!/bin/bash

#get text space
OLDIFS=$IFS
IFS=$'\n'

# path
locas="$(xlucy-path --locd)/answerslucy"
locai="$(xlucy-path --locai)"
locsa="$(xlucy-path --locsa)"

# get input
$locas "masukan pertanyaan untuk memanggil scripts"
read -p "? you : " you
if [ -z $you ];then
  $locas "empty input actions"; exit
fi
$locas "apa nama scripts nya ?"
read -p "? nama scripts : " ns
if [ -z $ns ];then
  $locas "empty input scripts name"; exit
fi

# empty array
declare -a arra arrai

# read input action
readfile(){
  arrai=( $(cat $1) )
  irai="${#arrai[@]}"
  nsa="o$ns.sh"

  # check array not empty
  if [[ $irai -eq 0 ]];then
    bqs=$you
  fi

  # check text qs full
  for i in ${!arrai[@]};do
    if [[ $i -eq 1000 ]];then
      touch "$locai/$2iactions.txt"
      $locas "try again < input full > create file input"; exit
    elif [[ $i -eq $((irai-1)) ]];then bqs=$you; fi
  done

  # check file scripts
  for fsa in $(ls $locsa);do
    if [[ "$ns.sh" == "${fsa:2}" ]];then ifsa=$fsa; fi
  done

  # create new file scripts
  if [ -z $ifsa ];then
    touch "$locsa/$3$nsa"
    echo -e "$bqs" >> $1
    $locas "suksess create actions scripts..."
  else
    $locas "input scripts name < $ns > sdh ada"
  fi
}

# file array input action
arra=( $(ls $locai) )
ia="${#arra[@]}"
idx=0

# read input action
for ira in ${!arra[@]};do
  # check input qs
  for rall in $(cat $locai/${arra[ira]});do ((idx++))
    if [[ $rall == $you ]];then
      $locas "input action < $you > sdh ada"; exit
    fi
  done

  # get end index
  if [[ $ira -eq $((ia-1)) ]];then
    if [ -f "$locai/${arra[ira]}" ];then
      readfile $locai/${arra[ira]} $ia $idx
    fi
  fi
done

echo "[!] run < xlucy -t > then < input question > for scripts test"
echo "[!] run < xlucy -p filescriptsactionX > for list scripts or edit"

#close text space
IFS=$OLDIFS
