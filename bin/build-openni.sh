#!/bin/bash

mp_code_dir=$1
chroots_base=$2
flag="build_completed.flag"

if [ -z "$chroots_base" ] || [ -z "$mp_code_dir" ]; then
    echo "Usage: ./build-chroot.sh [mp_vision_source_dir] [base chroot dir]"
	exit 1
fi

if ! git -C "$mp_code_dir" lfs ls-files > /dev/null; then
    echo "mp_vision and/or git lfs not found at $mp_code_dir"
    exit 1
fi

# Create a specific subdirectory inside the global chroots directory for this chroot. This allows
# a different version per branch, until Jenkins handles it for us.
chroot_name="master"
chroot_dir=$chroots_base/$chroot_name

function execute {
    sh -c "$*"|| { echo "----- failed in call '$*'"; exit 1; }
}
function execute_t {
    (command time -f "$* took %E" sh -c "$*") > /dev/null || { echo "----- failed in call '$*'"; exit 1; }
}
function chroot_execute {
    sudo chroot "$chroot_dir" sh -c "$*" || { echo "----- failed in chroot in call '$*'"; exit 1; }
}

function chroot_execute_t {
    (command time -f "$* in chroot took %E" sudo chroot "$chroot_dir" sh -c "$*") > /dev/null || { echo "----- failed in chroot in call '$*'"; exit 1; }
}


# openni2
echo '----- build openni (matterport custom)'
chroot_execute   'rsync -a --delete /root/mp_vision/thirdparty/OpenNI2/ /root/OpenNI2-matterport'
chroot_execute_t 'cd /root/OpenNI2-matterport && ARM_STAGING=/ ARM_CXX=arm-linux-gnueabihf-g++ PLATFORM=Arm make clean' # clean build in case a previous build has failed
# -Werror causes compilation to fail since newer compilers have newer warnings
chroot_execute_t 'cd /root/OpenNI2-matterport && ALLOW_WARNINGS=1 ARM_STAGING=/ ARM_CXX=arm-linux-gnueabihf-g++ PLATFORM=Arm CFLAGS=-I/root/libusb-build/include LDFLAGS=-L/root/libusb-build/lib make -j8'

