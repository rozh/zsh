####################
# General Settings #
####################
# export EDITOR=vim        # エディタをvimに設定
export EDITOR=nano
export LANG=en_US.UTF-8  # 文字コードをUTF-8に設定
# export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=u           # KCODEにUTF-8を設定
export AUTOFEATURE=true  # autotestでfeatureを動かす
export PATH="$PATH:$HOME/.script"
export OZHOME=$HOME/.oz
export PATH="$PATH:$OZHOME/bin"

setopt no_beep           # ビープ音を鳴らさないようにする
setopt auto_cd           # ディレクトリ名の入力のみで移動する
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
setopt correct           # コマンドのスペルを訂正する
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
setopt notify            # バックグラウンドジョブの状態変化を即時報告する
setopt equals            # =commandを`which command`と同じ処理にする

### Complement ###
fpath=($HOME/.zsh.d/zsh-completions/src $fpath)
autoload -U compinit; compinit # 補完機能を有効にする
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
setopt complete_in_word
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z} r:|[-_.]=**'
zstyle ':completion:*' user-cache yes
zstyle ':completion:*' verbose yes
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


### Glob ###
setopt extended_glob # グロブ機能を拡張する
unsetopt caseglob    # ファイルグロブで大文字小文字を区別しない

### History ###
HISTFILE=~/.zsh_history   # ヒストリを保存するファイル
HISTSIZE=5000            # メモリに保存されるヒストリの件数
SAVEHIST=5000            # 保存されるヒストリの件数
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt extended_history   # ヒストリに実行時間も保存する
setopt hist_ignore_dups   # 直前と同じコマンドはヒストリに追加しない
setopt hist_ignore_all_dups
setopt share_history      # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_ignore_space  # スペースで始まるコマンドラインはヒストリに追加しない。
setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する
setopt share_history      # zshプロセス間でヒストリを共有する。

# すべてのヒストリを表示する
function history-all { history -E 1 }

##########################
# Look And Feel Settings #
##########################
### Ls Color ###
# 色の設定
autoload -Uz colors
colors
export LSCOLORS=gxfxcxdxbxegedabagacad
# 補完時の色の設定
PROMPT='%B%{${fg[red]}%} $PS1_USER%{${fg[green]}%}@$(cat /var/run/ip_addr)${WINDOW:+":$WINDOW"}]%{%(?.$fg[yellow].$fg[red])%}%(!.#.$)%{${reset_color}%}%b '
if [ -f $HOME/.colorrc ];
then
    eval `dircolors -b $HOME/.colorrc`
fi
export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
autoload -Uz compinit
compinit

### Prompt ###
# 一般ユーザ時
tmp_prompt="
%{${fg[green]}%}[%D{%Y/%m/%d %T}]%{${reset_color}%} %U%{${fg[magenta]}%}%n%B@%m%b${reset_color}%}%u
%{${fg[cyan]}%}%# %{${reset_color}%}"
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color} %}"
tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [y, n, Abort, Edit]:%{${reset_color} %}"

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT="$tmp_rprompt$vcs_prompt"  # 右側のプロンプト(update by vcs.sh)
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト
# SSHログイン時のプロンプト
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"


### Title (user@hostname) ###
# case "${TERM}" in
# kterm*|xterm)
#     precmd() {
#         echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
#     }
#     ;;
# esac

case "$TERM" in
  dumb | emacs)
    PROMPT="%m:%~> "
    unsetopt zle
    ;;
esac

[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ '

##################
# Other Settings #
##################
### RVM ###
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

### Macports ###
case "${OSTYPE}" in
  darwin*)
    export PATH=/opt/local/bin:/opt/local/sbin:$PATH
    export MANPATH=/opt/local/share/man:/opt/local/man:$MANPATH
  ;;
esac
