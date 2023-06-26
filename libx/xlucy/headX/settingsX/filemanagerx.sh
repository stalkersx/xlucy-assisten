#!/bin/bash

#get file have is space
OLDIFS=$IFS
IFS=$'\n'

#dapatkan directory desainX
locd="$(xlucy-path --locd)"
notif=$1
skipd="$2"
warna="\e[0;32m"

#array kosong
declare -a tandai

#fungsi dapatkan karakter text
cekteks(){
  teks=`expr length $1`
  if [[ $teks -le 15 ]];then
    echo -e "\n\t\t\t! $1\n"
  elif [[ $teks -gt 15 ]] && [[ $teks -le 30 ]];then
    echo -e "\n\t\t! $1\n"
  elif [[ $teks -gt 30 ]] && [[ $teks -le 50 ]];then
    echo -e "\n\t! $1\n"
  elif [[ $teks -gt 50 ]];then
    echo -e "\n! $1\n"
  fi
}

#fungsi tabel lucyx
tabel(){
  clear
  if ! [ -f $locd/tabellucy ];then
    echo "[!] desainX : file <$locd/tabellucy> not found"; exit
  elif ! [ -f $locd/lucycontrol.txt ];then
    echo "[!] desainX : file <$locd/lucycontrol.txt> not found"; exit
  elif ! [ -f $locd/lucy.txt ];then
    echo "[!] desainX : file <$locd/lucy.txt> not found"; exit
  elif ! [ -f $locd/lucycontrolizin.txt ];then
    echo "[!] desainX : file <$locd/lucycontrolizin.txt> not found"; exit
  elif ! [ -f $locd/lucycontrolmake.txt ];then
    echo "[!] desainX : file <$locd/lucycontrolmake.txt> not found"; exit
  elif ! [ -f $locd/lucycontroltandai.txt ];then
    echo "[!] desainX : file <$locd/lucycontroltandai.txt> not found"; exit
  elif ! [ -f $locd/lucycontrolpath.txt ];then
    echo "[!] desainX : file <$locd/lucycontrolpath.txt> not found"; exit
  fi
  if [[ $1 -eq 0 ]] && [ $2 ];then
    cat $locd/lucy.txt; cekteks $2
    if [ $3 ];then echo -e "$3"; fi
  elif [[ $1 -eq 1 ]] && [ $2 ];then
    cat $locd/lucycontrol.txt; cekteks $2
    if [ $3 ];then echo -e "$3"; fi
  elif [[ $1 -eq 2 ]] && [ $2 ];then
    cat $locd/lucycontrolizin.txt; cekteks $2
  elif [[ $1 -eq 3 ]] && [ $2 ];then
    cat $locd/lucycontrolmake.txt; cekteks $2
  elif [[ $1 -eq 4 ]] && [ $2 ];then
    cat $locd/lucycontroltandai.txt; cekteks $2
  elif [[ $1 -eq 5 ]] && [ $2 ];then
    cat $locd/lucycontrolpath.txt; cekteks $2
    if [ $3 ];then echo -e "$3"; fi
  fi
  $locd/tabellucy
}

#tabellist
tabellist(){
  if ! [ -f $locd/$1 ];then
    echo "[!] desainX : file <$locd/$1> not found"; exit
  elif ! [ -f $locd/lucy.txt ];then
    echo "[!] desainX : file <$locd/lucy.txt> not found"; exit
  fi
  if [ $2 ];then
    cat $locd/lucy.txt; cekteks $2
    if [ $3 ];then echo -e "$3"; fi
    $locd/$1
  fi
}

#fungsi pindahkan file/folder
move(){
  echo; read -p "--> " me
  b=(`ls`)
  for i in ${!b[@]};do
    if [[ $me == $i ]];then
      file=${b[i]}; angka=$i
    fi
  done
}

#fungsi tandai beberapa file/folder
tandaifile(){
  a=0
  tabel 4 "tandai $1 file nomor?"
  while [ true ];do
    echo -e "\n[${#tandai[@]}] Tandai\n      |__ ${tandai[@]}"
    move me file angka
    if [[ $me == $angka ]] && ! [ -w $file ];then
      tabel 4 "tidak ada izin tulis(w) di file $file"
    elif [[ $me == $angka ]] && ! [ -r $file ];then
      tabel 4 "tidak ada izin baca(r) di file $file"
    elif [[ $me == $angka ]];then
      tandai[$angka]=$file
      tabel 4 "tandai $1 file nomor?"
    elif [[ $me == '*' ]];then
      for ts in `ls`;do
        tandai[$a]=$ts; ((a++))
      done
      tabel 4 "tandai $1 file nomor?"
    elif [[ $me == 's' ]];then
      if [[ ${tandai[@]} ]];then
        dn='s'; clear; break
      else
        tabel 4 "tidak ada yang ditandai"
      fi
    elif [[ $me == 'u' ]];then
      unset tandai
      tabel 4 "mengulang tandai kembali"
    elif [[ $me == 'q' ]];then clear; dn='q'
      break
    else
      tabel 4 "pilih angka yang mau ditandai untuk di$1"
    fi
  done
}

#fungsi dapatkan target path directory
targetloc(){
  tabel 5 "$1.ke?\n" "PATH\n  |__ $(pwd)\n"
  while [ true ];do
    echo -e "\n[${#tandai[@]}] Berkas\n    |__ ${tandai[@]}"
    move me file angka
    if [[ $me == $angka ]] && ! [ -w $file ] && [ -d $file ];then
      tabel 5 "tidak ada izin tulis(w) di file $file" "PATH\n  |__ $(pwd)\n"
    elif [[ $me == $angka ]] && ! [ -r $file ] && [ -d $file ];then
      tabel 5 "tidak ada izin baca(r) di file $file" "PATH\n  |__ $(pwd)\n"
    elif [[ $me == $angka ]] && ! [ -x $file ] && [ -d $file ];then
      tabel 5 "tidak ada izin exec(x) di file $file" "PATH\n  |__ $(pwd)\n"
    elif [[ $me == $angka ]];then
      if [ -d $file ];then
        for i in ${tandai[@]};do
          if [[ $i == $file ]];then
	    tabel 5 "target $1 adalah file yang dipilih" "PATH\n  |__ $(pwd)\n"; break
          else
            cd $file
            tabel 5 "membuka $file\n" "PATH\n  |__ $(pwd)\n"; break
	  fi
	done
      else
        tabel 5 "target $1 hanya ke folder" "PATH\n  |__ $(pwd)\n"
      fi
    elif [[ $me == 'k' ]];then
      cd ..; tabel 5 "kembali\n" "PATH\n  |__ $(pwd)\n"
    elif [[ $me == 's' ]];then
      dnl='s'; locb=`pwd`; break
    elif [[ $me == 'q' ]];then dnl='q'; break
    else
      tabel 5 "pilih angka untuk target lokasi $1" "PATH\n  |__ $(pwd)\n"
    fi
  done

}

#fungsi yes/no target path
yesnocph(){
  #question y/n tandai
  if [[ $1 == "copy" ]] || [[ $1 == "pindahkan" ]];then
    tabel 0 "apakah anda yakin ingin $1 file (y/n)?"
    echo -e "\n[${#tandai[@]}] Berkas\n    |__ [!] $1 : ${tandai[@]}\n    |__ [!] ke   : $3"
  else
    tabel 0 "apakah anda yakin ingin $1 file (y/n)?"
    echo -e "\n[${#tandai[@]}] Berkas\n    |__ [!] $1 : ${tandai[@]}"
  fi
  echo; read -p "--> " a
  if [[ $a == 'y' ]] || [[ $a == 'Y' ]];then
    for i in ${tandai[@]};do
      #copy
      if [[ $6 -eq 1 ]];then
        cp -rf $2/$i $3; cd $2
      #pindah
      elif [[ $6 -eq 2 ]];then
        mv $2/$i $3; cd $2
      #hapus
      elif [[ $6 -eq 3 ]];then
        rm -rf $i
      fi
    done
    tabel 1 $4
  elif [[ $a == 'n' ]] || [[ $a == 'N' ]];then
    tabel 1 $5
  else
    tabel 1 "pilih input (y/n) untuk save perubahan"
  fi
}

#method copy, move and delete file or folder
cmhfile(){
  #module
  tombolf=$1
  run=$2

  #path before(locl)
  locl=`pwd`

  #get array (tandai) file
  tandaifile $tombolf dn
  # get path new location(locb)
  if [[ $dn == 's' ]] && [ -z $3 ];then
    targetloc $tombolf locb dnl
    #check file new location(locb) same or not in array tandai
    datalocb=(`ls $locb`)
    for i in ${datalocb[@]};do
      for j in ${tandai[@]};do
        if [[ $i == $j ]];then
          checkdone="done"; notifcd="file $j sudah ada di $locb"
        fi
      done
    done
  #cancel get array (tandai) file
  elif [[ $dn == 'q' ]];then
    tabel 1 "membatalkan tandai $tombolf file"
  #run only for delete file or folder
  elif [ $3 ];then
    yesnocph $tombolf "null" "null" "$tombolf semua file berhasil" "$tombolf dibatalkan" $run
  fi

  #check run button(s)
  if [[ $dn == 's' ]] && [[ $dnl == 's' ]];then
    #check path new and before same or not
    if [[ $locl == $locb ]];then
      tabel 1 "pilih target lokasi lain"
    #clear check done tandai and locb
    elif [[ $checkdone == "done" ]];then
      tabel 1 $notifcd
    #run method question y/n
    else
      yesnocph $tombolf $locl $locb "$tombolf semua file berhasil" "$tombolf dibatalkan" $run
    fi
  #cancel get new location(targetloc)
  elif [[ $dn == "s" ]] && [[ $dnl == 'q' ]];then
    tabel 1 "membatalkan cari target $tombolf file"
  fi

  #clear variabel and array
  unset tandai; unset datalocb; unset checkdone; unset notifcd
  unset tombolf; unset run
}

#method yes/no
yesno(){
  tabel 0 $1
  echo; read -p "--> " tnyq
  if [[ $tnyq == "y" ]] || [[ $tnyq == "Y" ]];then
    if [[ $6 -eq 1 ]];then touch $5
    elif [[ $6 -eq 2 ]];then mkdir $5
    elif [[ $6 -eq 3 ]];then mv $5 $7
    fi
    tabel 1 $2
  elif [[ $tnyq == "n" ]] || [[ $tnyq == "N" ]];then
    tabel 1 $3
  else
    tabel 1 $4
  fi
}

#fungsi cetak file/folder baru
makefile(){
  #module
  typedata=$1
  run=$2

  #make new name file
  tabel 0 "apa nama $typedata baru nya?"
  echo; read -p "--> " nwfile

  #while for get name file already is have or not yet
  for i in `ls`;do
    if [[ $nwfile == $i ]];then
      nlfile=$i; break
    fi
  done

  #check new name file not empty
  if [ $nwfile ];then
    if [[ $nwfile == $nlfile ]];then
      tabel 1 "nama typedata $nwfile sudah ada"
    else
      #make file
      if [[ $run -eq 1 ]];then
        yesno "yakin untuk membuat $typedata $nwfile (y/n)?" "pembuatan $typedata $nwfile berhasil" "pembuatan $typedata $nwfile dibatalkan" "pilih input (y/n) untuk save perubahan" $nwfile 1
      #make directory
      elif [[ $run -eq 2 ]];then
        yesno "yakin untuk membuat $typedata $nwfile (y/n)?" "pembuatan $typedata $nwfile berhasil" "pembuatan $typedata $nwfile dibatalkan" "pilih input (y/n) untuk save perubahan" $nwfile 2
      fi
    fi
  else
    tabel 1 "tidak ada nama baru untuk membuat perubahan"
  fi
}

#fungsi buat file/folder baru
newfile(){
  tabel 3 "buat file atau folder?"
  echo; read -p "--> " tm
  case $tm in
    'f') makefile "file" 1;;
    'd') makefile "folder" 2;;
    'q') tabel 1 "pembuatan file/folder dibatalkan";;
      *) tabel 1 "pilih huruf yang tersedia untuk buat file atau folder";;
  esac
}

#fungsi ganti nama file/folder
renamefile(){
  tabel 0 "file mana yang mau diganti nama?"
  move me file angka
  if [[ $me == $angka ]] && ! [ -w $file ];then
    tabel 1 "tidak ada izin tulis(w) di file $file"
  elif [[ $me == $angka ]];then
    tabel 0 "apa nama file barunya?"
    echo; read -p "--> " newname
    if [ $newname ];then
      yesno "yakin untuk ganti nama $file ke $newname (y/n)?" "ganti nama $file ke $newname berhasil" "ganti nama $file ke $newname dibatalkan" "pilih input (y/n) untuk save perubahan" $file 3 $newname
    else
      tabel 1 "tidak ada nama baru untuk membuat perubahan"
    fi
  else
    tabel 1 "pilih angka file untuk rename"
  fi
}

givepermissions(){
  opsi=$1; run=$2; clear
  tabellist "tabelizin" "pilih opsi perizinan $run" "\nDetail\n  |__ [r=izin baca] [w=izin tulis] [x=izin eksekusi bash]\n"
  echo; read -p "--> " gopsi
  case $gopsi in
    '0') chmod $opsi+r $run
         tabel 1 "file $run berhasil diberi izin baca(+r)";;
    '1') chmod $opsi+w $run
         tabel 1 "file $run berhasil diberi izin tulis(+w)";;
    '2') chmod $opsi+x $run
         tabel 1 "file $run berhasil diberi izin eksekusi(+x)";;
    '3') chmod $opsi+rw $run
         tabel 1 "file $run berhasil diberi izin baca dan tulis(+rw)";;
    '4') chmod $opsi+rx $run
         tabel 1 "file $run berhasil diberi izin.baca dan eksekusi(+rx)";;
    '5') chmod $opsi+wx $run
         tabel 1 "file $run berhasil diberi izin tulis dan eksekusi(+wx)";;
    '6') chmod $opsi+rwx $run
         tabel 1 "file $run berhasil diberi izin baca, tulis dan eksekusi(+rwx)";;
    '7') chmod $opsi-r $run
         tabel 1 "file $run berhasil dicopot izin baca(-r)";;
    '8') chmod $opsi-w $run
         tabel 1 "file $run berhasil dicopot izin tulis(-w)";;
    '9') chmod $opsi-x $run
         tabel 1 "file $run berhasil dicopot izin eksekusi(-x)";;
    '10') chmod $opsi-rw $run
         tabel 1 "file $run berhasil dicopot izin baca dan tulis(-rw)";;
    '11') chmod $opsi-rx $run
         tabel 1 "file $run berhasil dicopot izin baca dan eksekusi(-rx)";;
    '12') chmod $opsi-wx $run
         tabel 1 "file $run berhasil dicopot izin tulis dan eksekusi(-wx)";;
    '13') chmod $opsi-rwx $run
         tabel 1 "file $run berhasil dicopot izin baca, tulis dan eksekusi(-rwx)";;
      *) tabel 1 "pilih angka opsi yang tersedia";;
  esac
}

#get opsi permissions
getopsi(){
  tabel 2 "pilih izin pada file $1"
  echo; read -p "--> " opsi
  case $opsi in
    'a') givepermissions "a" $1;;
    'u') givepermissions "u" $1;;
    'g') givepermissions "g" $1;;
    'o') givepermissions "o" $1;;
      *) tabel 1 "pilih huruf file yang tersedia";;
  esac
}

#method get permissions file
gpermissionsf(){
  tabel 0 "beri perizinan pada file ?" "PERMISSIONS\n     |__ [drwx_rwx_rwx=all] [drwx=user] [rwx=grub] [rwx=other]\n"
  move me file angka
  if [[ $me == $angka ]];then
    getopsi $file
  else
    tabel 1 "pilih angka untuk beri perizinan file"
  fi
}

#fungsi edit file
editfile(){
  tabel 0 "file mana yang akan diedit?"
  move me file angka
  if [[ $me == $angka ]] && ! [ -w $file ];then
    tabel 1 "tidak ada izin tulis(w) di file $file"
  elif [[ $me == $angka ]] && ! [ -r $file ];then
    tabel 1 "tidak ada izin baca(r) di file $file"
  elif [[ $me == $angka ]] && [ -f $file ];then clear
    if [ -f /bin/nano ] || [ -f $PREFIX/bin/nano ];then
      nano -l $file; tabel 1 "edit $file"
    else
      tabel 1 "tools <nano> tidak terinstall"
    fi
  elif [[ $me == $angka ]] && [ -d $file ];then
    tabel 1 "folder tidak dapat diedit"
  else
    tabel 1 "pilih angka file untuk edit"
  fi
}

#fungsi eksekusi file
execfile(){
  tabel 0 "file mana yang akan dijalankan dengan bash?"
  move me file angka
  if [[ $me == $angka ]] && ! [ -w $file ];then
    tabel 1 "tidak ada izin tulis(w) di file $file"
  elif [[ $me == $angka ]] && ! [ -r $file ];then
    tabel 1 "tidak ada izin baca(r) di file $file"
  elif [[ $me == $angka ]] && [ -f $file ];then
    if [ -x $file ];then clear
      ./$file
    else
      tabel 1 "tidak ada izin eksekusi(x) file $file"
    fi
  elif [[ $me == $angka ]] && [ -d $file ];then
    tabel 1 "folder tidak dapat dijalankan"
  else
    tabel 1 "pilih angka file untuk exec file"
  fi
}

#fungsi tampilkan ukuran file
ukuranfile(){
  tabel 0 "file mana yang akan ditampilkan ukuran?"
  move me file angka
  if [[ $me == $angka ]] && ! [ -w $file ];then
    tabel 1 "tidak ada izin tulis(w) di file $file"
  elif [[ $me == $angka ]] && ! [ -r $file ];then
    tabel 1 "tidak ada izin baca(r) di file $file"
  elif [[ $me == $angka ]] && [ -r $file ] && [ -f $file ] || [ -d $file ];then
    tabel 1 "jumblah `du -sh $file` (ukuran.file)"
  else
    tabel 1 "pilih angka file untuk tampilkan ukuran file"
  fi
}

#tombol input lucyx
tabel 1 $notif
while [ true ];do
  move me file angka
  if [ -z $me ];then
    tabel 1 "input kosong"; continue
  fi
  if [[ $me == $angka ]] && ! [ -w $file ];then
    tabel 1 "tidak ada izin tulis(w) di file $file"
  elif [[ $me == $angka ]] && ! [ -r $file ];then
    tabel 1 "tidak ada izin baca(r) di file $file"
  elif [[ $me == $angka ]] && [ -d $file ] && [ -x $file ];then
    cd $file; tabel 1 "membuka $file"
  elif [[ $me == $angka ]] && [ -f $file ];then
    less $file; tabel 1 "membuka $file"
  elif [[ $me == 'b' ]];then newfile
  elif [[ $me == 'c' ]];then cmhfile "copy" 1
  elif [[ $me == 'm' ]];then cmhfile "pindahkan" 2
  elif [[ $me == 'h' ]];then cmhfile "hapus" 3 "null"
  elif [[ $me == 'r' ]];then renamefile
  elif [[ $me == 'x' ]];then execfile
  elif [[ $me == 'u' ]];then ukuranfile
  elif [[ $me == 'i' ]];then gpermissionsf
  elif [[ $me == 'p' ]];then tabel 1 "menampilkan lokasi path anda berada" "PATH\n  |_ `pwd`\n"
  elif [[ $me == 'k' ]];then phl=$(pwd); cd ..; ph=$(pwd)
    if ! [ -r $ph ];then cd $phl
      tabel 1 "path <$ph> tidak ada izin baca(r)"
      unset phl; unset ph; continue
    fi
    if [[ $phl == $skipd ]];then cd $phl; unset phl; unset ph
      tabel 1 "\"q\" untuk keluar pengaturan"
      unset phl; unset ph; continue
    fi
    unset phl; unset ph; tabel 1 "kembali"
  elif [[ $me == 'e' ]];then editfile
  elif [[ $me == "q" ]];then
    exit
  else
    tabel 1 "pilih angka atau huruf yang tersedia"
  fi
done
echo $skipd $ph
#end get have is space
IFS=$OLDIFS

#by : @hatreds
