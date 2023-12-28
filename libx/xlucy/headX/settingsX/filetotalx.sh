#!/bin/bash

# array file
declare -a svnf svnd svall
jf=0

# total file or directory in path
jfile(){
  for scan in $(ls);do
    # scan file or folder
    if [ -f $scan ];then
      if [[ $1 -eq 2 ]];then
        echo "[f] $(pwd)/$scan"
      else
        svnf[$jf]="$scan"
      fi
    elif [ -d $scan ];then
      if [[ $1 -eq 2 ]];then
        echo "[d] $(pwd)/$scan"
      else
        svnd[$jf]="$scan"
      fi
    fi
    ((jf++))

    # no path to path
    if [[ $1 -eq 1 ]];then continue; fi

    # path to path
    if [ -d $scan ] && [ -r $scan ];then cd $scan; jfile $1; cd ..; fi
  done
}

# check size all file in directory
sfile(){
	for sz in $(ls -a);do
	  echo $(du -sh $sz)
	done
}

# check path total file
if [ -d $1 ] && [[ $2 -eq 1 ]];then cd $1; jfile
elif [ -d $1 ] && [[ $2 -eq 2 ]];then cd $1; jfile 1
elif [ -d $1 ] && [[ $2 -eq 3 ]];then cd $1; jfile 2
elif [ -d $1 ] && [[ $2 -eq 4 ]];then cd $1; sfile
else
  echo "[!] path < $1 > unknown"; exit
fi

# show
if [[ $2 -eq 1 ]] || [[ $2 -eq 2 ]];then
  echo "[!] TOTAL : "
  echo "[f] ${#svnf[@]} file"
  echo "[d] ${#svnd[@]} folder"
fi
