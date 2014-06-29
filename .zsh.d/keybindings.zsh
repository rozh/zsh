bindkey -e               # キーバインドをemacsモードに設定

bindkey "\eb" reverse-menu-complete   # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)

# マッチしたコマンドのヒストリを表示できるようにする
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey -M emacs '^[p' history-substring-search-up
bindkey -M emacs '^[n' history-substring-search-down
# bindkey "^[p" history-beginning-search-backward-end
# bindkey "^[n" history-beginning-search-forward-end
# zle -la history-incremental-pattern-search-backward
# zle -la history-incremental-pattern-search-forward
# bindkey "^r" history-incremental-pattern-search-backward
# bindkey "^s" history-incremental-pattern-search-forward

# ワードごとに削除
autoload -U select-word-style
select-word-style bash
bindkey '^[^?' backward-kill-word # alt + BACKSPACE  delete word backward
bindkey '^W'   backward-kill-word # alt + BACKSPACE  delete word backward
bindkey "^[f"  forward-word
bindkey "^[b"  backward-word

# zaw
bindkey '^xb' zaw-cdr
bindkey '^x^x' zaw-history

# my function
zle -N parent_directory
zle -N back_directory
zle -N do_enter
bindkey '^u' parent_directory
bindkey '^o' back_directory
bindkey '^m' do_enter

function parent_directory() {
    builtin cd ../
    my-reset-prompt
    return 0
}

function back_directory() {
    builtin cd -
    my-reset-prompt
    return 0
}

function my-reset-prompt() {
    echo
    ls
    echo
    echo
    zle reset-prompt
}

function do_enter() {
    # ls_abbrev
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo
        echo -e "\e[0;33m--- git status ---\e[0m"
        git status -sb
    fi
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    my-reset-prompt
    return 0
}

source $HOME/.zsh.d/percol.zsh
bindkey '^R' percol_select_history
bindkey '^x^b' percol_cd_history
bindkey '^xb' percol_insert_history
