export PATH="$HOME/.rbenv/bin:$PATH"

bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"


  
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1='\[\e[0;31m\]\!\[\e[0;39m\][\t \[\033[1;34m\]\h:\[\033[0m\]\[\e[0;34m\]\w\[\e[0;32m\]$(parse_git_branch)\[\e[0;39m\]]\n \$ '



