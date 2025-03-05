#!/bin/bash

cd ~/gammacal
date > ~/gammacal_listing.txt
if [ "$(ls)" ]; then
    find . -iname "*.identity" >> ~/gammacal_listing.txt
else
    echo "mount directory sir"
fi
