#!/bin/bash

cd ~/dev

free=$(df ~/matterport | tail -1 | awk 'BEGIN{FS=" "} {print $4}')
if [ "$free" -lt 16000000 ]; then
    cd ~/matterport/mp_backup
    TOPDIR=$(ls -1 | head -1)
    rm -rf "$TOPDIR"
    echo "removed $TOPDIR"
fi


BACKUP="/home/phahn/matterport/mp_backup/$(date +"%y-%m-%d")"
if [ ! -d "$BACKUP" ]; then
    mkdir "$BACKUP";
fi
tar zcf "$BACKUP/mp_vision-git.tar.gz" mp_vision/.git
cd -

