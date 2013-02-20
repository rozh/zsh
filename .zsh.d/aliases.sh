###########
# Aliases #
###########
alias r=rails
alias v=vim
alias e='emacsclient'
alias sl=ls
alias cd../='cd ../'
alias eixt=exit
alias shut='sudo shutdown -h now'
alias suspend='~/.script/suspend'
alias off='xset dpms force off'

# enable color support of ls and also add handy aliases
if [ -f ~/.colorrc ]; then
    eval `dircolors -b ~/.colorrc` || eval "$(dircolors -b)"
    alias ls='ls -GF --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


# cdコマンド実行後、lsを実行する
function cd() {
    builtin cd $@ && ls;
}

# autojump
[[ -s ~/.autojump/etc/profile.d/autojump.zsh ]] && . ~/.autojump/etc/profile.d/autojump.zsh
