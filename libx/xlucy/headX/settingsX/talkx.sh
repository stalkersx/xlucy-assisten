#!/bin/bash

#get text space
OLDIFS=$IFS
IFS=$'\n'

# variabel directory path
locp="$(xlucy-path --locs)/permissionx.sh"
locas="$(xlucy-path --locd)/answerslucy"
locqi="$(xlucy-path --locqi)"
locqo="$(xlucy-path --locqo)"
locai="$(xlucy-path --locai)"
locsa="$(xlucy-path --locsa)"

#color
warna="\e[0;35m"
echo -e "$warna"

# read text in directory
readfile(){
  if [ $1 ];then
    a=(`ls $1`)
    for i in ${a[@]};do
      if [ -f $1/$i ];then
        cat $1/$i
      fi
    done
  else
    echo "[!] file < $1 > not found"; exit 1
  fi
}

# read question input
qsi=(`readfile $locqi`)
ai=(`readfile $locai`)

# read question output
qso=(`readfile $locqo`)
ao=( $(ls $locsa) )

# question to lucy
condisional(){
  #while input question
  for gq in ${!qsi[@]};do
    if [[ $me == ${qsi[gq]} ]];then
      imq=${qsi[gq]}; sheq=${qso[gq]}
    fi
  done

  #while input action
  for ga in ${!ai[@]};do
    if [[ $me == ${ai[ga]} ]];then
      ima=${ai[ga]}; shea=${ao[ga]}
    fi
  done

  # check action
  if [[ $me == $imq ]] || [[ $me == "$imq?" ]];then
    $locas $sheq
  elif [[ $me == $ima ]];then
    sdea=${shea: -3}
    if [[ $sdea == ".sh" ]];then
      $locp -rwx $locsa/$shea
      $locas "wait ..."; sleep 1; clear; exec $locsa/$shea
    else
      $locas "unknown bash scripts"
    fi
  # exit program
  elif [[ $me == "exit" ]] || [[ $me == "byee" ]];then
    exit
  # unknown input
  else
    $locas "maaf, aku ga paham"
  fi
}

# STARTING
# talking with lucy
$locas "hai..."
while [ true ];do
  read -p "? " me
  if [ -z $me ];then
    $locas "mau nanya apa?"; continue
  fi
  condisional
done

#close text space
IFS=$OLDIFS
