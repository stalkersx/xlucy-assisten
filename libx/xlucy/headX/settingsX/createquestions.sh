#!/bin/bash

#get text space
OLDIFS=$IFS
IFS=$'\n'

# path
locas="$(xlucy-path --locd)/answerslucy"
locqi="$(xlucy-path --locqi)"
locqo="$(xlucy-path --locqo)"

# remembers question
remember(){
  $locas "apa kamu mau aku mengingatnya ?"
  arrjy=("ya" "iya" "baik" "oke" "y" "iya deh" "yup")
  arrjn=("tidak" "ga" "gak" "ga mau" "n")
  read -p "y/n ? " inpt
  for i in ${!arrjy[@]};do
    if [[ ${arrjy[i]} == $inpt ]];then next="ok"
    elif [[ ${arrjn[i]} == $inpt ]];then
      $locas "create questions cancel"; exit
    fi
  done

  if [[ $next == "ok" ]];then
    echo $1 >> $2; echo $3 >> $4
    $locas "suksess create questions"
  else
    remember $1 $2 $3 $4
  fi
}

# read file inout
readfile(){
  arrqi=( $(ls $locqi) )
  iqi="${#arrqi[@]}"
  dqi="iquestions.txt"
  arrqo=( $(ls $locqo) )
  oqo="${#arrqo[@]}"
  dqo="oquestions.txt"

  # read question input
  for i in ${!arrqi[@]};do
    for k in $(cat $locqi/${arrqi[i]});do
      if [[ $1 == $k ]];then $locas "$2 sudah ada"; exit; fi
    done

    if [[ $i -eq $((iqi-1)) ]];then
      rqs1=( $(cat $locqi/${arrqi[i]}) )
      for j in ${!rqs1[@]};do
        if [[ $j -eq 1000 ]];then
          touch "$locqi/$((iqi+1))$dqi"
          $locas "try again < text full > create new file"; exit
        fi
      done
      dataqi=${arrqi[i]}
    fi
  done

  # read question output
  for l in ${!arrqo[@]};do
    for m in $(cat $locqo/${arrqo[l]});do
      if [[ $1 == $m ]];then $locas "$2 sudah ada"; exit; fi
    done

    if [[ $i -eq $((oqo-1)) ]];then
      rqs2=( $(cat $locqo/${arrqo[l]}) )
      for o in ${!rqs2[@]};do
        if [[ $o -eq 1000 ]];then
          touch "$locqo/$((oqo+1))$dqo"
          $locas "try again < text full > create new file"; exit
        fi
      done
      dataqo=${arrqo[l]}
    fi
  done
}

# get input questions
$locas "masukan teks yang akan kamu tanyakan ke lucy"
read -p "? you : " tyou
if [ -z $tyou ];then
  $locas "input pertanyaan kosong"
else
  readfile $tyou "pertanyaan" dataqi
  ginp=1
fi

# get output questions
$locas "masukan jawaban yang akan lucy berikan"
read -p "? lucy : " jlucy
if [ -z $jlucy ];then
  $locas "input jawaban lucy kosong"
else
  readfile $jlucy "jawaban lucy" dataqo
  gout=2
fi

# ask next or not
if [[ $ginp -eq 1 ]] && [[ $gout -eq 2 ]];then
  remember $tyou $locqi/$dataqi $jlucy $locqo/$dataqo
else
  $locas "questions create is failed"
fi

echo "[!] run < xlucy -t > for questions to lucy"

# close text space
IFS=$OLDIFS
