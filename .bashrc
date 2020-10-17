# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF --color'
alias la='ls -A --color'
alias l='ls -CF --color'
alias lr='less -R'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi



############### Custom ######################
set -o vi
export PS1='\[\e[0;31m\]\!\[\e[0;37m\][\t \[\033[0m\]\[\e[0;34m\]\w\[\e[0;32m\]$(parse_git_branch)\[\e[0;37m\]]\n$(parse_user) '

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

alias srb="source ~/.bashrc"

export PATH=$PATH:~/bin:~/dev/mp_vision/tools/mcp
export PATH="$PATH:"/opt/microchip/xc32/v1.43/bin""
export PATH="$PATH:"/opt/microchip/xc16/v1.32/bin""
export PATH="/opt/microchip/xc16/v1.11/bin":"~/mp_vision-build":$PATH
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export CDPATH=$CDPATH:~/dev/:~/dev/zaya_app

export MPCH=matterport@10.88.90.1:/home/matterport
export MPC=10.88.90.1
export PSF=/media/psf/Home/
export MP_VISION_SRC=~/dev/mp_vision
export MPV=~/dev/mp_vision
export MPB=~/mp_vision-build
export LEOS=/chroots/$(cat ~/.fwb_chroot)/root/build-dev/libeos.so
export LEOSP=/chroots/$(cat ~/.fwb_chroot)/root/build-prod/libeos.so
export LEOSM=/chroots/master/root/build-dev/libeos.so
export LEOSMP=/chroots/master/root/build-prod/libeos.so
export LNX=~/dev/linux-imx6/ubuntunize/linux-3.14.52*
export MPD=/home/phahn/matterport/
export FLAGF=/home/phahn/bin/camera_manager.flagfile

# pro3
export ZAP=~/dev/zaya_app
export ZAB=~/docker-zaya
export ZMC=~/dev/zaya_mcu

export LFT=$HOME/JetPack/64_TX2/Linux_for_Tegra/

CAMERA_IP=10.77.80.1
CAMERA_SSH=matterport@$CAMERA_IP
TOOLS_DIR="$MPV/tools"
CURL_CMD="$TOOLS_DIR/mcp/curl_camera.sh"
KEYS="--cert $TOOLS_DIR/keys/mcp-client-cert.crt --key $TOOLS_DIR/keys/mcp-client-cert.key"
STAT_CMD="stat -c%s"

parse_user() { 
    if [ "$USER" == "root" ]; then
        echo "*$"
    else
        echo " $"
    fi
}
parse_git_branch() { 
    branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    commit=$(git log 2> /dev/null | head -1 | awk '{print $2}')
    if [ "$branch" ]; then
        echo " ($branch:${commit:0:5})"
    fi
}
cgrep() { 
    grep --color "$@" 
}
gacr() {
  git add -u
  git commit -m "rev"
  git rebase -i $1
}
glog() { 
    git log --pretty=oneline --abbrev-commit | head -n8 
}
gareb() { 
    git add -u && git commit -m "rev" && git rebase -i HEAD^^ 
}
greb() {
  git stash -k
  git commit -m "rev" && git rebase -i HEAD^^
  git stash pop
}
gl() { 
    git ll | head -n 10 
}
fwcm() {
    if [ -n "$1" ]; then
        sudo chroot /chroots/master sh -c "cd /root/build-prod; CC=/usr/bin/aarch64-linux-gnu-gcc CXX=/usr/bin/aarch64-linux-gnu-g++ cmake -DCMAKE_BUILD_TYPE=Camera -DEOS_PRODUCTION=1 -DEOS_STRIP=1 -DPROTOBUF_INCLUDE_DIR=/root/mp_vision/thirdparty/protobuf/protobuf-3.2.0/src -DPROTOBUF_LIBRARY=/root/protobuf-3.2.0/libprotobuf.a -DPROTOBUF_PROTOC_EXECUTABLE=/root/protobuf-3.2.0-host-binaries/bin/protoc -DLIBUSB_1_INCLUDE_DIR=/root/libusb-build/include/libusb-1.0 -DLIBUSB_1_LIBRARY=/root/libusb-build/lib/libusb-1.0.so.0 /root/mp_vision"
    else
        sudo chroot /chroots/master sh -c "cd /root/build-dev; CC=/usr/bin/aarch64-linux-gnu-gcc CXX=/usr/bin/aarch64-linux-gnu-g++ cmake -DCMAKE_BUILD_TYPE=Camera -DPROTOBUF_INCLUDE_DIR=/root/mp_vision/thirdparty/protobuf/protobuf-3.2.0/src -DPROTOBUF_LIBRARY=/root/protobuf-3.2.0/libprotobuf.a -DPROTOBUF_PROTOC_EXECUTABLE=/root/protobuf-3.2.0-host-binaries/bin/protoc -DLIBUSB_1_INCLUDE_DIR=/root/libusb-build/include/libusb-1.0 -DLIBUSB_1_LIBRARY=/root/libusb-build/lib/libusb-1.0.so.0 /root/mp_vision"
    fi
}
fwc() {
    echo "fwb_chroot is $(cat ~/.fwb_chroot)"
    if [ -n "$1" ]; then
        sudo chroot /chroots/$(cat ~/.fwb_chroot) cd /root/build-prod; CC=/usr/bin/aarch64-linux-gnu-gcc CXX=/usr/bin/aarch64-linux-gnu-g++ cmake -DCMAKE_BUILD_TYPE=Camera -DEOS_PRODUCTION=1 -DEOS_STRIP=1 -DPROTOBUF_INCLUDE_DIR=/root/mp_vision/thirdparty/protobuf/protobuf-3.2.0/src -DPROTOBUF_LIBRARY=/root/protobuf-3.2.0/libprotobuf.a -DPROTOBUF_PROTOC_EXECUTABLE=/root/protobuf-3.2.0-host-binaries/bin/protoc -DLIBUSB_1_INCLUDE_DIR=/root/libusb-build/include/libusb-1.0 -DLIBUSB_1_LIBRARY=/root/libusb-build/lib/libusb-1.0.so.0 /root/mp_vision
    else
        sudo chroot /chroots/$(cat ~/.fwb_chroot) cd /root/build-dev; CC=/usr/bin/aarch64-linux-gnu-gcc CXX=/usr/bin/aarch64-linux-gnu-g++ cmake -DCMAKE_BUILD_TYPE=Camera -DPROTOBUF_INCLUDE_DIR=/root/mp_vision/thirdparty/protobuf/protobuf-3.2.0/src -DPROTOBUF_LIBRARY=/root/protobuf-3.2.0/libprotobuf.a -DPROTOBUF_PROTOC_EXECUTABLE=/root/protobuf-3.2.0-host-binaries/bin/protoc -DLIBUSB_1_INCLUDE_DIR=/root/libusb-build/include/libusb-1.0 -DLIBUSB_1_LIBRARY=/root/libusb-build/lib/libusb-1.0.so.0 /root/mp_vision
    fi
}
cfwr(){
    if [ -z "$1" ]; then
        CHROOT_NAME=$(git branch | grep \* | cut -d ' ' -f2)
    else
        CHROOT_NAME=$1
    fi
    echo "$CHROOT_NAME" > ~/.fwb_chroot
    export LEOS=/chroots/$(cat ~/.fwb_chroot)/root/build-dev/libeos.so
    export LEOSP=/chroots/$(cat ~/.fwb_chroot)/root/build-prod/libeos.so
    echo "fwb_chroot is $CHROOT_NAME, LEOS is $LEOS"
    mchr
}
fwbm() { 
    if [ -n "$1" ]; then
        sudo chroot /chroots/master make -C /root/build-prod -j8 base_app 
    else
        sudo chroot /chroots/master make -C /root/build-dev -j8 base_app 
    fi
}
fwb() { 
    echo "fwb_chroot is $(cat ~/.fwb_chroot)"
    if [ -n "$1" ]; then
        sudo chroot /chroots/$(cat ~/.fwb_chroot) make -C /root/build-prod -j8 base_app 
    else
        sudo chroot /chroots/$(cat ~/.fwb_chroot) make -C /root/build-dev -j8 base_app 
    fi
}
kernb() { 
    ./make_mtp.sh ~/dev/qcacld-2.0/ ~/dev/kernel-module-imx-gpu-viv/ 
}
dit() { 
    CAMERA_IP=10.77.80.1
    TOOLS_DIR="$MPV/tools"
    KEYS="--cert $TOOLS_DIR/keys/mcp-client-cert.crt --key $TOOLS_DIR/keys/mcp-client-cert.key"
    get_state=
    while [ ! $get_state ]; do
        get_state=$(curl -m 1 -k --ciphers ALL $KEYS https://$CAMERA_IP/getState 2>/dev/null)
        get_state=$(echo "$get_state" | sed 's|\\"|"|g' | sed 's|\\\\\\||g')
    done

    serial=$(echo "$get_state" | sed -E 's/.*cameraSerial\":\"([0-9A-Z]*).*/\1/g')
    echo "Camera Serial: $serial"
    $CURL_CMD "disableIdleTimeouts" 
    echo "$get_state"

}
mchr() {
    MPOINT=/chroots/$(cat ~/.fwb_chroot)/root/mp_vision
    if ! mount -l | grep "$MPOINT"; then
        sudo mount --bind "/home/phahn/dev/mp_vision" "$MPOINT"
        sudo mount -o remount,ro "$MPOINT"
        sudo mount -t proc proc "/chroots/$(cat ~/.fwb_chroot)/proc"
    fi
    MPOINT=/chroots/master/root/mp_vision
    if ! mount -l | grep "$MPOINT"; then
        sudo mount --bind "/home/phahn/dev/mp_vision" "$MPOINT"
        sudo mount -o remount,ro "$MPOINT"
        sudo mount -t proc proc "/chroots/master/proc"
    fi
}
sweep() {
    if [ ! -d ~/Desktop/sweeps ]; then
        mkdir ~/Desktop/sweeps
    fi
    cd ~/Desktop/sweeps
    sweep.sh "$@"
}
sweepr() {
    if [ ! -d ~/Desktop/sweeps ]; then
        mkdir ~/Desktop/sweeps
    fi
    cd ~/Desktop/sweeps
    sweep.sh --cont
}
bsubm() {
    if ping -c1 -w3 10.77.80.1 >/dev/null 2>&1; then
        dit
        cd mp_vision/tools/update_tools
        ./build-submit.sh -c master $1
        cd -
    else
        echo "Connect to camera"
    fi
}

bsub() {
    if ping -c1 -w3 10.77.80.1 >/dev/null 2>&1; then
        dit
        cd mp_vision/tools/update_tools
        ./build-submit.sh -c "$(cat ~/.fwb_chroot)" $1
        cd -
    else
        echo "Connect to camera"
    fi
}

stssh() {
    if ping -c1 -w3 10.77.80.1 >/dev/null 2>&1; then
        cd update_tools
        ./submit-apply-update.sh ../keys ../updates/update-start-ssh.tar
        cd -
    else
        echo "Connect to camera"
    fi
}

chroot_dir="/chroots/arm-cross-gcc5/"
function chroot_execute {
    sudo chroot "$chroot_dir" sh -c "$*" 
}

function chroot_execute_t {
    (command time -f "$* in chroot took %E" sudo chroot "$chroot_dir" sh -c "$*")
}

onibuild() {
    echo '----- build openni (matterport custom)'
    chroot_execute   'mount -t proc proc /proc'
    chroot_execute   'rsync -a /root/mp_vision/thirdparty/OpenNI2/ /root/OpenNI2-matterport'
    chroot_execute_t 'cd /root/OpenNI2-matterport && ARM_STAGING=/ ARM_CXX=arm-linux-gnueabihf-g++ PLATFORM=Arm make'
}

gammalist() {
    cd ~/gammacal
    date > ~/gammacal_listing.txt
    if [ "$(ls)" ]; then
        find . -iname "*.identity" >> ~/gammacal_listing.txt
    fi
}

shad() {
    ssh-add ~/gammacal/"$(grep "$1" ~/gammacal_listing.txt)"
}

resub() {
    dit
    cd mp_vision/tools/update_tools
    ./submit-apply-update.sh ../keys home-matterport/update-*.tar
    cd -
}

function set-title() {
  if [[ -z "$ORIG" ]]; then
    ORIG=$PS1
  fi
  TITLE="\[\e]2;$*\a\]"
  PS1=${ORIG}${TITLE}
}

ascp() {
    sshTest
    ret="$?"
    if [ "$ret" -ne 0 ]; then
        echo "Unable to SSH to camera"
    else
        scp "$@"
    fi
}
LFT422=/home/phahn/JetPack_4.2.2_Nano/Linux_for_Tegra
LFT43=/home/phahn/JetPack_4.3_Nano/Linux_for_Tegra

source /home/phahn/cam_tools/mcp/common.sh

append_authorized() {
    cat ~/.ssh/id_rsa.pub | ssh zayawifi tee -a .ssh/authorized_keys
}

sett() {
    set-title $(basename $(pwd))
}
