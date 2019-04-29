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
export PS1='\[\e[0;31m\]\!\[\e[0;37m\][\t \[\033[0m\]\[\e[0;34m\]\w\[\e[0;32m\]$(parse_git_branch)\[\e[0;37m\]]\n $ '

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
export CDPATH=$CDPATH:~/dev/:~/dev/mp_vision/tools

export MPCH=matterport@10.77.80.1:/home/matterport
export MPC=matterport@10.77.80.1
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

CAMERA_IP=10.77.80.1
CAMERA_SSH=matterport@$CAMERA_IP
TOOLS_DIR="$MPV/tools"
CURL_CMD="$TOOLS_DIR/mcp/curl_camera.sh"
KEYS="--cert $TOOLS_DIR/keys/mcp-client-cert.crt --key $TOOLS_DIR/keys/mcp-client-cert.key"
STAT_CMD="stat -c%s"

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
    fi
    MPOINT=/chroots/master/root/mp_vision
    if ! mount -l | grep "$MPOINT"; then
        sudo mount --bind "/home/phahn/dev/mp_vision" "$MPOINT"
        sudo mount -o remount,ro "$MPOINT"
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
    if [ -n "$1" ]; then
        if [ "$1" == "p" ]; then
            fwbm p
            cd $MPV/tools/update_tools
            sed -i "s/build-dev/build-prod/g" create-update-body.sh
            git add create-update-body.sh
        else
            fwbm
        fi
        if [ "$?" -eq 0 ]; then
            cd update_tools
            sudo ./create-update-body.sh
            cd home-matterport
            sudo ../sign-create-update.sh ../gamma_update_private_key.pem
            cd -
        fi
    else
        if ping -c1 -w3 10.77.80.1 >/dev/null 2>&1; then
            dit
            cd update_tools
            ./build-submit.sh -c master
            cd -
        else
            echo "Connect to camera"
        fi
    fi
}

bsub() {
    if [ -n "$1" ]; then
        if [ "$1" == "p" ]; then
            fwb p
            cd $MPV/tools/update_tools
            sed -i "s/build-dev/build-prod/g" create-update-body.sh
            git add create-update-body.sh
        else
            fwb
        fi
        if [ "$?" -eq 0 ]; then
            cd update_tools
            sudo ./create-update-body.sh
            cd home-matterport
            sudo ../sign-create-update.sh ../gamma_update_private_key.pem
            cd -
        fi
    else
        if ping -c1 -w3 10.77.80.1 >/dev/null 2>&1; then
            dit
            cd update_tools
            ./build-submit.sh -c "$(cat ~/.fwb_chroot)"
            cd -
        else
            echo "Connect to camera"
        fi
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

function mountCalRecords() {
    CALRECS_IP=10.2.10.10
    ping "$PING_ARGS" "$CALRECS_IP" >/dev/null 2>&1
    ret=$?
    if [ $ret -eq 0 ]; then
        # If server is not accessible then cifs will hang on directory access,
        # so don't check for existence unless ping succeeds
        if [ ! -d $HOME/CalRecords/gamma ]; then
            echo "$HOME/CalRecords is empty or not mounted."  
            echo "Needed for keys to ssh into camera."
            echo "Check with manufacturing team for access to CalRecords on 10.2.10.10"
            read -p "Enter username for diskstation (10.2.10.10): " USERNAME
            read -s -p "Enter password for diskstation (10.2.10.10): " PASSWORD
            echo ""

            if [ ! -d $HOME/CalRecords ]; then
                echo "Creating directory $HOME/CalRecords"
                mkdir $HOME/CalRecords
            fi

            echo "Mounting 10.2.10.10/CalRecords to ~/CalRecords"
            if [[ "$OSTYPE" =~ "darwin" ]]; then
                mount_smbfs //$USERNAME:$PASSWORD@10.2.10.10/CalRecords $HOME/CalRecords
            else # otherwise assume running on linux
                echo "Installing cifs-utils"
                sudo apt -y install cifs-utils
                sudo mount -t cifs -o username="$USERNAME",password="$PASSWORD" //10.2.10.10/CalRecords "$HOME"/CalRecords
            fi

            if [ ! -d $HOME/CalRecords/gamma ]; then
                echo "Mounting CalRecords failed"
                return 1
            fi

            USERNAME=""
            PASSWORD=""
        fi
        CALRECS_AVAIL=true
    else
        CALRECS_AVAIL=""
    fi
}

ssh_add() {
    if [ "$1" ]; then
        serial=$1
    else
        get_state="$($CURL_CMD getState 2>/dev/null)"
        serial=$(echo "$get_state" | sed -E 's/.*cameraSerial\":\"([0-9A-Z]*).*/\1/g')
    fi

    LOCAL_SSHKEY_PATH=$HOME/.ssh/$serial.identity
    if [ -f "$LOCAL_SSHKEY_PATH" ]; then
        SSHKEY_PATH=$LOCAL_SSHKEY_PATH
    else
        mountCalRecords
        if [ "$CALRECS_AVAIL" ]; then
            if [[ $serial =~ M....... ]]; then
                # last two characters in serial e.g. M02FFK2S ==> 2S
                folder_prefix=${serial:6:2}
            else
                # first two characters in serial e.g. P216 ==> P2
                folder_prefix=${serial:0:2}
            fi
            CALREC_SSHKEY_PATH=$HOME/CalRecords/gamma/$folder_prefix/$serial/SSH_key.identity
            SSHKEY_PATH=$CALREC_SSHKEY_PATH
        else
            SSHKEY_PATH=""
            echo "Neither CalRecords nor local copy of key available"
            return 1
        fi
    fi
    
    if [ "$SSHKEY_PATH" ]; then
        ssh-add "$SSHKEY_PATH"
        if [ $? -eq 0 -a ! -f $LOCAL_SSHKEY_PATH ]; then
            # make a local copy of the SSH key so camera can be accessed
            # later without connection to CalRecords
            echo "Copying $serial SSH key to $LOCAL_SSHKEY_PATH"
            cp $SSHKEY_PATH $LOCAL_SSHKEY_PATH
            chmod 0600 $LOCAL_SSHKEY_PATH
        fi
    fi
}

function sshTest() {
    PING_ARGS="-w 1 "
    if [[ "$OSTYPE" =~ "darwin" ]]; then
        PING_ARGS="-t 1 -c 1 "
    fi
    ping "$PING_ARGS" "$CAMERA_IP" >/dev/null 2>&1
    ret="$?"

    if [ "$ret" -ne 0 ]; then
        echo "Pinging camera timed out, check wifi connection"
        return 1
    else
        # use SSH test args if user sent any
        if [ "$#" -eq 0 ]; then
            # test printing empty string
            SSH_TESTARGS="printf \"\""
        else
            SSH_TESTARGS="$@"
        fi

        $CURL_CMD "disableIdleTimeouts" >/dev/null 2>&1
        ssh_add

        if [ -n "$(echo "$get_state" | grep "\-P")" ]; then
            # quick check SSH before starting server
            ssh $CAMERA_SSH "$SSH_TESTARGS"
            ret=$?
            if [ $ret -ne 0 ]; then
                echo "Found production version fw, starting SSH"
                cd $TOOLS_DIR/update_tools
                ./submit-apply-update.sh ../keys ../updates/update-start-ssh.tar
                cd -
                sleep 1 # let ssh server start
            else
                return 0;
            fi
        else
            echo "Running dev firmware"
        fi

        ssh $CAMERA_SSH "$SSH_TESTARGS"
        ssh_ret=$?

        if [ "$ssh_ret" -ne 0 -a "$SSHKEY_PATH" ]; then
            echo "Clearing SSH keys..."
            ssh-add -D
            ssh-add $SSHKEY_PATH
            ssh $CAMERA_SSH "$SSH_TESTARGS" 
            if [ "$?" -ne 0 ]; then
                return 1
            fi
        elif [ "$ssh_ret" -ne 0 ]; then
            echo "Unable to add keys for camera. Connect to internet, source common.sh, and run ssh_add $serial"
            return 1
        fi
    fi
    return 0
}

function ssh_camera() {
    # test SSH with any input arguments
    sshTest "$@"
    ret="$?"
    if [ "$ret" -ne 0 ]; then
        echo "Unable to SSH to camera"
    else
        # if no input arguments then start the SSH terminal session now
        if [ "$#" -eq 0 ]; then
            ssh $CAMERA_SSH
            ret=$?
        fi
    fi
    return "$ret"
}





lograb() {
    if [ -z "$1" ]; then
        echo "specify output directory"
    else
        sshTest
        ret="$?"
        if [ "$ret" -ne 0 ]; then
            echo "Unable to SSH to camera"
            return 1
        else
            if [ -n "$serial" ]; then
                if [ ! -d "$1" ]; then
                    mkdir "$1";
                fi
                cd "$1"
                if [ -d "$serial" ]; then
                    echo "$serial logs directory already exists"
                else
                    echo "mkdir "$serial""
                    mkdir "$serial"
                    if [ "$2" == "all" ]; then
                        ssh $CAMERA_SSH 'sudo chmod 0644 /var/log/upstart/camera_manager*'
                        scp $CAMERA_SSH:/var/log/upstart/camera_manager.log* $serial
                        gunzip -f $serial/*.gz
                        for i in {9..1}; do cat $serial/camera_manager.log.$i >> $serial/camman_all; done
                        cat $serial/camera_manager.log >> $serial/camman_all
                        rm $serial/camera_manager*
                        mv $serial/camman_all $serial/camera_manager.all

                        ssh $CAMERA_SSH 'sudo chmod 0644 /var/log/syslog*'
                        scp $CAMERA_SSH:/var/log/syslog* $serial
                        gunzip -f $serial/*.gz
                        for i in {9..1}; do cat $serial/syslog.$i >> $serial/systemlog_all; done
                        cat $serial/syslog >> $serial/systemlog_all
                        rm $serial/syslog*
                        mv $serial/systemlog_all $serial/syslog.all
                    else
                        scp $CAMERA_SSH:/home/matterport/eos/eos.log* $serial
                        gunzip -f $serial/*.gz
                        for i in {9..0}; do cat $serial/eos.log.$i >> $serial/eoslog_all; done
                        cat $serial/eos.log >> $serial/eoslog_all
                        rm $serial/eos.log*
                        mv $serial/eoslog_all $serial/eos.all
                    fi
                fi
                cd -
            else
                echo "no serial found"
            fi
        fi
    fi
    return 0
}
  

sshcam() {
    # test SSH with any input arguments
    sshTest "$@"
    ret="$?"
    if [ "$ret" -ne 0 ]; then
        echo "Unable to SSH to camera"
    else
        # if no input arguments then start the SSH terminal session now
        if [ "$#" -eq 0 ]; then
            ssh $CAMERA_SSH
            ret=$?
        fi
    fi
    return "$ret"
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
    cd update_tools
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
