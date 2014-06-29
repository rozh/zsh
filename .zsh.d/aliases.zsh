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
alias du='du -ms'

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

# alias -s
alias -s rb=ruby
alias -s py=python
alias -s sh=sh
alias -s plt=gnuplot
alias -s {png,jpg,bmp,PNG,JPG,BMP}=eog
alias -s {eps,pdf,ai}=evince
alias -s {doc,xls,ppt,docx,xlsx,pptx}=libreoffice
alias -s {opt,ods,odp,csv}=libreoffice
alias -s html=chromium-browser
alias -s {mp3,mp4,avi,MOV}=vlc
function runcpp () {
    g++ -O2 $1
    shift
    ./a.out $@
}
alias -s {c,cpp}=runcpp
function runjava () {
    className=$1
    className=${className%.java}
    javac $1
    shift
    java $className $@
}
alias -s java=runjava


function extract() {
  case $1 in
    *.tar.gz|*.tgz) tar xzvf $1;;
    *.tar.xz) tar Jxvf $1;;
    *.zip) unzip $1;;
    *.lzh) lha e $1;;
    *.tar.bz2|*.tbz) tar xjvf $1;;
    *.tar.Z) tar zxvf $1;;
    *.gz) gzip -d $1;;
    *.bz2) bzip2 -dc $1;;
    *.Z) uncompress $1;;
    *.tar) tar xvf $1;;
    *.arj) unarj $1;;
  esac
}
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract


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
[[ -s /usr/share/autojump/autojump.zsh ]] && source /usr/share/autojump/autojump.zsh
