#######################################################################
# ------------------------------------------------------------------- #
#######################################################################
function percol_select_history() {
  local tac_cmd
  which gtac &> /dev/null && tac_cmd=gtac || tac_cmd=tac
  BUFFER=$($tac_cmd ~/.zsh_history | sed 's/^: [0-9]*:[0-9]*;//' \
    | percol --match-method regex --query "$LBUFFER")
  CURSOR=$#BUFFER         # move cursor
  zle -R -c               # refresh
}
zle -N percol_select_history

#######################################################################
# ------------------------------------------------------------------- #
#######################################################################
function percol-git-recent-branches () {
    local selected_branch=$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads | \
        perl -pne 's{^refs/heads/}{}' | \
        percol --query "$LBUFFER")
    if [ -n "$selected_branch" ]; then
        BUFFER="git checkout ${selected_branch}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N percol-git-recent-branches

#######################################################################
# ------------------------------------------------------------------- #
#######################################################################
function percol-git-recent-all-branches () {
    local selected_branch=$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads refs/remotes | \
        perl -pne 's{^refs/(heads|remotes)/}{}' | \
        percol --query "$LBUFFER")
    if [ -n "$selected_branch" ]; then
        BUFFER="git checkout -t ${selected_branch}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N percol-git-recent-all-branches


#######################################################################
# ------------------------------------------------------------------- #
#######################################################################
# {{{
# cd �����Ͽ
typeset -U chpwd_functions
CD_HISTORY_FILE=${HOME}/.cd_history_file # cd ����ε�Ͽ��ե�����
function chpwd_record_history() {
    echo $PWD >> ${CD_HISTORY_FILE}
}
chpwd_functions=($chpwd_functions chpwd_record_history)

# percol ��Ȥä� cd ������椫��ǥ��쥯�ȥ������
# ����ˬ������¿���ۤ��������ξ�����
function percol_get_destination_from_history() {
    sort ${CD_HISTORY_FILE} | uniq -c | sort -r | \
        sed -e 's/^[ ]*[0-9]*[ ]*//' | \
        sed -e s"/^${HOME//\//\\/}/~/" | \
        percol | xargs echo
}

# percol ��Ȥä� cd ������椫��ǥ��쥯�ȥ������ cd ���륦�������å�
function percol_cd_history() {
    local destination=$(percol_get_destination_from_history)
    [ -n $destination ] && cd ${destination/#\~/${HOME}}
    zle reset-prompt
}
zle -N percol_cd_history

# percol ��Ȥä� cd ������椫��ǥ��쥯�ȥ������,���ߤΥ���������֤��������륦�������å�
function percol_insert_history() {
    local destination=$(percol_get_destination_from_history)
    if [ $? -eq 0 ]; then
        local new_left="${LBUFFER} ${destination} "
        BUFFER=${new_left}${RBUFFER}
        CURSOR=${#new_left}
    fi
    zle reset-prompt
}
zle -N percol_insert_history
# }}}
