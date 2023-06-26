#!/data/data/com.termux/files/usr/bin/bash

# show notification about command
notif(){
	if [[ $1 -eq 0 ]]; then
		echo -e "$3[#] done ... Installation Complete"; exit
	elif [[ $1 -eq 1 ]]; then
		echo -e "$3[#] OK ... file <$2> found"
	elif [[ $1 -eq 2 ]]; then
		echo -e "$3[!] NO ... file <$2> not found"; exit
	elif [[ $1 -eq 3 ]]; then
		echo -e "$3[#] OK ... directory <$2> found"
	elif [[ $1 -eq 4 ]]; then
		echo -e "$3[!] NO ... directory <$2> not found"; exit
	elif [[ $1 -eq 5 ]]; then
		echo -e "$3[#] OK ... already installation <$2>"
	fi
}

# method check data
check_file(){
	if [ -f $1 ]; then $2; else $3; $4; $5; fi
}

check_directory(){
	if [ -d $1 ]; then $2; else $3; $4; $5; fi
}

# check shell
if [ -d $PREFIX ];then path="/data/data/com.termux/files"
elif [ -d /usr ];then path=""
else
  echo "[!] unknown shell"
fi

# variabel your data
data1="$path/usr/bin"
data2="$path/usr/lib"
data3="xlucy-path"
data4="xlucy"
data5="binx"
data6="libx"

# color
red="\e[0;31m"
green="\e[0;32m"

# command shell
command="[#] command ..."
command1="cp $data5/$data3 $data1"
command2="cp $data5/$data4 $data1"
command3="cp -rf $data6/$data4 $data2"
command4="chmod +x $data1/$data3"
command5="chmod +x $data1/$data4"

# just running in directory
if ! [ -d $data5 ] || ! [ -d $data6 ];then
  echo -e "$red[!] running install in directory xlucy-assisten"; exit
fi

# INSTALL
check_directory $data1 "notif 3 $data1 $green" "notif 4 $data1 $red"
check_directory $data1 "notif 3 $data2 $green" "notif 4 $data2 $red"
check_file "$data5/$data3" "notif 1 $data5/$data3 $green" "notif 2 $data5/$data3 $red"
check_file "$data5/$data4" "notif 1 $data5/$data4 $green" "notif 2 $data5/$data4 $red"
check_directory "$data6/$data4" "notif 1 $data6/$data4 $green" "notif 2 $data6/$data4 $red"
check_file "$data1/$data3" "notif 5 $data1/$data3 $green" "$command1" "$command4"
check_file "$data1/$data4" "notif 5 $data1/$data4 $green" "$command2" "$command5"
check_directory "$data2/$data4" "notif 5 $data2/$data4 $green" "$command3"
notif 0 "null" $green
