#!/bin/bash
exportFolder="/c/Users/phn/Desktop/export"

folderList=`sed "s|^|$exportFolder/|" lastcmd.dirs`

if [[ "$1" == "?" ]]; then
  count=1
  IFS=$'\n'
  echo "-----------"
  for dir in $folderList; do

    echo "dir $count: "$dir""
    ls -l "$dir"
    echo "-----------"

    let count=count+1

  done

  echo ""
  lastcmdvalue=`cat lastcmd.val`
  echo "last command was: $lastcmdvalue"

  exit
fi

if [ -z "$1" ]; then
  lastcmdvalue=`cat lastcmd.val`
  echo "using directory $lastcmdvalue"
  requested=$lastcmdvalue
else
  case "$*" in
      ''|*[!0-9]*) numberArg="false";;
      *) numberArg="true";;
  esac

  if [ "$*" == "?" ]; then
    numberArg="true";
  fi

  if [ $numberArg == "false" ]; then
    targetFolder=$exportFolder/"$*"
    if [ ! -d "$targetFolder" ]; then
      echo "make new folder "$targetFolder""
      mkdir "$targetFolder"

    else 
      echo "dir exists"
      lineNum=`awk "/$*\// {print NR}" lastcmd.dirs`
    fi

    if [ -z "$lineNum" ]; then
      echo "dir not in list"
      echo "$*/" >> lastcmd.dirs
      lineNum=`awk "/$*\// {print NR}" lastcmd.dirs`
    fi
    echo "dir line $lineNum"

  else
    echo "number arg"
    lineNum="$1"
  fi
fi


requested="$lineNum"
store="New folder"


count=1
IFS=$'\n'
for dir in $folderList; do

  if [[ "$count" -eq "$requested" ]]; then 
    echo "uploading "$dir""
    ./flickr_up.py -d "$dir"
    if [ ! -d "$dir"/"$store" ]; then
      mkdir "$dir"/"$store"
    fi
    mv "$dir"/*.jpg "$dir"/"$store"
   fi

   let count=count+1

done

lastcmdvalue=$requested
echo $lastcmdvalue > lastcmd.val


