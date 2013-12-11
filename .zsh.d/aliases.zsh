###########
# Aliases #
###########
alias r=rails
alias v=vim
alias e='emacsclient'
alias em='emacs -nw -q -l ~/.emacs.d/nw.init.el'
alias sl=ls
alias cd../='cd ../'
alias eixt=exit
alias shut='sudo shutdown -h now'
alias suspend='gnome-screensaver-command --lock && sudo s2ram -f'
alias lock='gnome-screensaver-command --lock'

# enable color support of ls and also add handy aliases
if [ -f ~/.colorrc ]; then
    eval `dircolors -b ~/.colorrc` || eval "$(dircolors -b)"
    alias ls='ls -GF --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias pdfgrep='pdfgrep -Hn --color auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lt='ls -t'

# cdコマンド実行後、lsを実行する
function cd() {
    builtin cd $@ && ls;
}

alias ggl=google
function google() {
    local str opt
    if [ $# != 0 ]; then # 引数が存在すれば
        for i in $*; do
            str="$str+$i"
        done
        str=`echo $str | sed 's/^\+//'` #先頭の「+」を削除
        opt='search?num=50&hl=ja&ie=euc-jp&oe=euc-jp&lr=lang_ja'
        opt="${opt}&q=${str}"
    fi
    chromium-browser http://www.google.com/$opt #引数がなければ $opt は空になる
}


# autojump
[[ -s ~/.autojump/etc/profile.d/autojump.zsh ]] && . ~/.autojump/etc/profile.d/autojump.zsh
