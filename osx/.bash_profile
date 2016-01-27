export PATH="$HOME/.rbenv/bin:$PATH"
# export PATH=$PATH:/Users/phahn/Dev/android-ndk-r9c
# export TARGET_PRODUCT=msm8974

# alias lb3='ssh linux-builder3'
# alias lb3c='ssh -Yt -C -c arcfour linux-builder3'
alias mvm=gvim
# alias cvm='vim -u ~/.cvim/.cvimrc'
# alias scvm='sudo vim -u ~/.cvim/.cvimrc'

# alias arbl='adb reboot-bootloader;'
# alias areb='adb reboot'
#alias ffla='cd /Volumes/home/dragonfly/lytro; time ./flash.sh blitzen; cd -'
#alias fflaq='cd /Volumes/home/dragonfly/lytro; time ./flash.sh blitzen modem sbl1 rpm dbi tz boot system userdata recovery cache; cd -'
# alias apus='cd /Volumes/home/dragonfly/LINUX/android/; time ./push.sh; cd -'
# alias freb='fastboot reboot'
alias vi="open -t $1"
# alias vim="vim -u ~/.vimrc_term --noplugin"
# alias uu="uu.pl 10.0.40.91 admin:12345" 

# cycle() { command curl -s -u admin:12345 http://10.0.40.91/outlet?${1}=CCL >/dev/null ; }
# off() { command curl -s -u admin:12345 http://10.0.40.91/outlet?${1}=OFF >/dev/null ; }
# on() { command curl -s -u admin:12345 http://10.0.40.91/outlet?${1}=ON >/dev/null ; }


if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# alternatively:
#test -f ~/.git-completion.bash && . $_
#Note: $_ means the last argument to the previous command. so . $_ means run it - "it" being .git-completion.bash in this case
#

set -o vi

# Fix $PATH for homebrew
homebrew=/usr/local/bin:/usr/local/sbin
export PATH=$homebrew:$PATH

# add bin to path
export PATH=~/bin:$PATH


export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export ghard=/jaunt/groups/hardware
export pancam=/users/peterh/dev/mac/pancam
export neo=$pancam/hardware/neofirmware
export neolib=$pancam/hardware/neolib
export cmd=$pancam/hardware/neolib/build/cmdLine
export amba21neo=$neo/AmbaRelease_21-neo
export amba21uc=$neo/AmbaRelease_21-uc
export amba212neo=$neo/AmbaRelease_21-2-neo
export amba212evk=$neo/AmbaRelease_21-2-evk
export amba212uc=$neo/AmbaRelease_21-2uc
export fwprogbin=A9/Common/FwProg/bin
export allout=A9/Common/FwProg/build/Release/Uniprocessor/Exe/AmbaARM11NandProg_ALL_1_LPDDR2.out
export sysout=A9/Common/FwProg/build/Release/Uniprocessor/Exe/AmbaARM11NandProg_SYS_1.out
export evkallout=A9/Common/FwProg/build/Release/Uniprocessor/Exe/AmbaARM11NandProg_ALL_1_DDR3.out
export evksysout=A9/Common/FwProg/build/Release/Uniprocessor/Exe/AmbaARM11NandProg_SYS_1.out
export sysfw=A9/Common/FwProg/bin/AmbaSYS.devfw
export sysdsp=A9/Common/FwProg/bin/Amba_SYS_DSP_ROM.devfw
export bstsys=A9/Common/FwProg/bin/Amba_BST_BLD_SDF_SYS_DSP_ROM.devfw
export evksys=A9/Common/FwProg/bin/Amba_SYS_DSP_ROM.devfw
export markdownfile=/users/peterh/tmp/Release.md

export ifwr=/jaunt/groups/hardware/internal_fw_releases/Neo/IMX174

#mkfile() { mkdir -p -- '$1' && touch -- '$1'/'$2' }
crfile() { 
    mkdir -p $1
    touch $1/$2
}


parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1='\[\e[0;31m\]\!\[\e[0;30m\][\t \[\033[1;34m\]\h:\[\033[0m\]\[\e[0;34m\]\w\[\e[0;32m\]$(parse_git_branch)\[\e[0;30m\]]\n \$ '


bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

cd ~/dev/mac/pancam/hardware/neofirmware


export CSCOPE_EDITOR=vim


gnfw() {
  cd ~/dev/mac/pancam/
  git checkout -- hardware/neofirmware/Jaunt/Platform/NeoFwVersion.h
  cd -
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
