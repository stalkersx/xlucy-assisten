#!/bin/bash

#openspace
OLDIFS=$IFS
IFS=$'\n'

# path
locas="$(xlucy-path --locd)/answerslucy"
locsa="$(xlucy-path --locsa)/sadata"

# open window
winopen(){
  for i in {0..70};do
    if [[ $i -eq 0 ]];then
      printf "╭"
    elif [[ $i -eq 70 ]];then
      printf "╮"
    else
      printf "—"
    fi
  done
  echo
}

#close window
winclose(){
  for i in {0..70};do
    if [[ $i -eq 0 ]];then
      printf "╰"
    elif [[ $i -eq 70 ]];then
      printf "╯"
    else
      printf "—"
    fi
  done
  echo
}

#show list
gettext(){
   a="$(expr length $1)"
   b=0
   while [[ $b -le $a ]];do
     c[$b]=${1:$b:1}; ((b++))
   done

   s=" "
   d=0; gline=$2; gspace=$((gline+a))
   for n in {0..70};do
     if [[ $n -eq 0 ]] || [[ $n -eq 70 ]];then
       printf "|"
     elif [[ $n -gt $gline ]];then
       printf "${c[d]}"; ((d++))
     fi
     if [[ $n -lt $gline ]];then
       printf "$s"
     elif [[ $n -gt $gspace ]];then
       printf "$s"
     fi
   done
   echo; unset c
}

# tabel list
tlist(){
  getd=( $(cat $locsa/hdata.txt) )
  gett=( $(cat $locsa/tdata.txt) )
  d1="${getd[0]}"
  d2="${getd[1]}"; s1=$((d1+d2))
  d3="${getd[2]}"; s2=$((s1+d3))
  d4="${getd[3]}"; s3=$((s2+d4))
  d5="${getd[4]}"; s4=$((s3+d5))
  d6="${getd[5]}"; s5=$((s4+d6))
  d7="${getd[6]}"; s6=$((s5+d7))
  d8="${getd[7]}"; s7=$((s6+d8))
  d9="${getd[8]}"; s8=$((s7+d9))
  d10="${getd[9]}"; s9=$((s8+d10))
  d11="${getd[10]}"; s10=$((s9+d11))
  d12="${getd[11]}"; s11=$((s10+d12))
  d13="${getd[12]}"; s12=$((s11+d13))
  d14="${getd[13]}"; s13=$((s12+d14))
  d15="${getd[14]}"; s14=$((s13+d15))
  d16="${getd[15]}"; s15=$((s14+d16))
  d17="${getd[16]}"; s16=$((s15+d17))
  d18="${getd[17]}"; s17=$((s16+d18))
  d19="${getd[18]}"; s18=$((s17+d19))
  d20="${getd[19]}"; s19=$((s18+d20))
  d21="${getd[20]}"; s20=$((s19+d21))
  d22="${getd[21]}"; s21=$((s20+d22))
  d23="${getd[22]}"; s22=$((s21+d23))
  d24="${getd[23]}"; s23=$((s22+d24))
  d25="${getd[24]}"; s24=$((s23+d25))
  d26="${getd[25]}"; s25=$((s24+d26))
  d27="${getd[26]}"; s26=$((s25+d27))
  d28="${getd[27]}"; s27=$((s26+d28))
  d29="${getd[28]}"; s28=$((s27+d29))
  d30="${getd[29]}"; s29=$((s28+d30))
  d31="${getd[30]}"; s30=$((s29+d31))
  if [[ $1 -eq 1 ]];then
    clear; winopen
    for gdt in ${!getd[@]};do
      gettext "$gdt. ${getd[gdt]} embr       [${gett[gdt]}]" 2
    done; winclose
    echo "[!] harga : $(cat $locsa/kdata.txt) rupiah"
    echo "[!] total : $s30 embr"
  elif [[ $1 -eq 2 ]];then
    harga=$(cat $locsa/kdata.txt)
    stotal=$(($s30*$harga))
    sidx="$(expr length $stotal)"
    n=0
    if [[ $sidx -eq 6 ]];then
      while [[ $n -lt $sidx ]];do
        totals+=${stotal:$n:1}
        if [[ $n -eq 2 ]];then totals+="."; fi
        ((n++))
      done
    elif [[ $sidx -eq 7 ]];then
      while [[ $n -lt $sidx ]];do
        totals+=${stotal:$n:1}
        if [[ $n -eq 0 ]];then totals+="."
        elif [[ $n -eq 3 ]];then totals+="."; fi
        ((n++))
      done
    fi
    $locas "pendapatan anda $totals rupiah"
  fi
}

# tabel menu
tmenu(){
  gmenu=("tambah data" "tampilkan data" "tampilkan pendapatan" "edit harga" "clear data")
  winopen
  for gd in ${!gmenu[@]};do
    gettext "$gd. ${gmenu[gd]}" 2
  done
  winclose
  read -p "pilih : " plh
  if [[ $plh == "0" ]];then
    $locas "masukan tanggal hari ini"
    read -p "? " tgl
    echo $tgl >> $locsa/tdata.txt
    $locas "pendapatan harian anda"
    read -p "? " pen
    echo $pen >> $locsa/hdata.txt
    $locas "add data complete ..."
  elif [[ $plh == "1" ]];then tlist 1
  elif [[ $plh == "2" ]];then tlist 2
  elif [[ $plh == "3" ]];then
    $locas "berapa harga /kilo"
    read -p "? " hk
    ghk=( $(cat $locsa/kdata.txt) )
    if [ ${#ghk[@]} ];then
      rm $locsa/kdata.txt; touch $locsa/kdata.txt
    fi
    echo $hk >> $locsa/kdata.txt
    $locas "change harga complete ..."
  elif [[ $plh == "4" ]];then
    if [ -f $locsa/kdata.txt ] && [ -f $locsa/hdata.txt ];then
      rm $locsa/kdata.txt; rm $locsa/hdata.txt
      $locas "reset data complete ..."
      touch $locsa/kdata.txt; rm $locsa/hdata.txt
    fi
  else
    $locas "pilih angka ditabel"
  fi
}

askagain(){
  read -p "[?] back to menu (y/n) : " bm
  if [[ $bm == "y" ]] || [[ $bm == "Y" ]];then clear; tmenu; askagain
  elif [[ $bm == "n" ]] || [[ $bm == "N" ]];then xlucy -t
  else
    $locas "hanya pilih y/n"; askagain
  fi
}

# call method
tmenu
askagain

# close space
IFS=$OLDIFS
