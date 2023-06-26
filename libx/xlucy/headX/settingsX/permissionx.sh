#!/bin/bash

# notification
notif(){
  echo "[!] $1"
}

# get permission read,write,and exec
izinrwx(){
  if ! [ -r $1 ];then chmod u+r $1
  elif ! [ -w $1 ];then chmod u+w $1
  elif ! [ -x $1 ];then chmod u+x $1
  fi
}
izinrw(){
  if ! [ -r $1 ];then chmod u+r $1
  elif ! [ -w $1 ];then chmod u+w $1
  fi
}

dirf(){
  if [ -f $1 ];then $2
  elif [ -d $1 ];then $2
  fi
}

# STARTING

# permission file
if [[ $1 == "-rw" ]] && [ -z $3 ];then dirf $2 "izinrw $2"
# permission directory
elif [[ $1 == "-rwx" ]] && [ -z $3 ];then dirf $2 "izinrwx $2"
else
  notif "try < permissionx.sh -rw/-rwx > for command"
fi
