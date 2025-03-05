#!/bin/bash


echo "enter file with cherry pick commits.  Commits will"
echo "be taken from end of list first.  options: "
echo "    -c to continue"
echo "    -a to abort a commit"
echo "    -r to resume from last point"

ABORT=""
CONTINUE=""
 
if [ "$1" == "-a" ]; then
    file=$(cat ~/bin/cherrypick.current)
    echo "Continuing from $file"
    orig_list=$(cat ${file}.tmp)
    list="$(cat ${file}.tmp | sed '1!G;h;$!d')"
    ABORT=1
elif [ "$1" == "-c" ]; then
    file=$(cat ~/bin/cherrypick.current)
    echo "Continuing from $file"
    orig_list=$(cat ${file}.tmp)
    list="$(cat ${file}.tmp | sed '1!G;h;$!d')"
    CONTINUE=1
elif [ "$1" == "-r" ]; then
    file=$(cat ~/bin/cherrypick.current)
    echo "Resuming from $file"
    orig_list=$(cat ${file}.tmp)
    list="$(cat ${file}.tmp | sed '1!G;h;$!d')"
else
    if [ ! -f "$1" ]; then
        echo "specify input list file $1"
        return 1
    fi

    if [ -f "$1.tmp" ]; then
        orig_list=$(cat $1.tmp)
        list="$(cat $1.tmp | sed '1!G;h;$!d')"
    else
        orig_list=$(cat $1)
        list="$(cat $1 | sed '1!G;h;$!d')"
        cat "$1" > "${1}.tmp"
    fi
    echo "$1" > ~/bin/cherrypick.current
    file=$1
fi



#echo "$list"
#exit 0

IFS=$'\n'
for item in $list; do
    commit="$(echo "$item" | awk '{ print $1; }')"
    echo "current commit is: $commit"
    if [ $(echo "$item" | grep "Merge pull request") ]; then
        echo "skipping merge commit"
        RETC=0
    else
        if [ "$ABORT" ]; then
            git cherry-pick --abort
            echo "removing commit $commit"
            orig_list=$(echo "$orig_list" | sed "/$commit/d")
            echo "$orig_list" > $file.tmp
            ABORT=""
            continue
        fi

        if [ "$CONTINUE" ]; then
            git cherry-pick --continue
            RETC=$?
        else
            git cherry-pick "$commit"
            RETC=$?
        fi
    fi
    if [ "$RETC" -eq 0 ]; then
        orig_list=$(echo "$orig_list" | sed "/$commit/d")
        echo "$orig_list" > $file.tmp
        if [ $CONTINUE ]; then
            CONTINUE=""
        fi
    else
        git mergetool
        echo "exiting"
        break
    fi
done

if [ -z "$(cat $file.tmp)" ]; then
    rm $file.tmp
fi
