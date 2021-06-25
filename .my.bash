function _update_ps1() {
    PS1=$(~/.local/bin/powerline-shell $?)
}

function ga() {
    git add ${*}
}

function gb() {
    git branch ${*}
}

function gc() {
    git commit ${*}
}

function gco() {
    git checkout ${*}
}

function gcp() {
    git cherry-pick -n -x ${*}
}

function gd() {
    git diff ${*}
}

function gdc() {
    git diff --cached ${*}
}

function gdb() {
    gd develop...HEAD ${*}
}

function gdr() {
    gd HEAD...develop ${*}
}

function gf() {
    git find ${*}
}

function gl() {
    git log --name-status ${*}
}

function glb() {
    gl develop..HEAD ${*}
}

function glr() {
    gl HEAD..develop ${*}
}

function gp() {
    git pull
}

function grs() {
    git restore --staged ${*}
}

function gs() {
    git status
}

function gsu() {
    if [ -z "${GSU_REPOS}" ]
    then
        echo "Define GSU_REPOS to contain your desired repositories for reporting."
        return
    fi
    declare -A DAYS
    DAYS["Mon"]=3
    DAYS["Tue"]=1
    DAYS["Wed"]=1
    DAYS["Thu"]=1
    DAYS["Fri"]=2
    DAYS["Sat"]=1
    DAYS["Sun"]=1
    pushd . >/dev/null
    for REPO in ${GSU_REPOS}
    do
        cd ${REPO}
        basename ${REPO}
        git standup -d ${1:-${DAYS[$(date +%a)]}}
        echo
    done
    popd >/dev/null
}

function gu() {
    git reset --soft HEAD~1
}

function title() {
    echo -en "\e]2;$1\a"
}

function unpack() {
    [ -z ${1} ] && { echo "Usage: ${0} <package>"; return 1; }
    [ -f ${1} ] || { echo "No such package."; return 1; }
    DIR=${1%.tar.*}
    [ -d ${DIR} ] && { echo "Package already extracted."; return 1; }
    [ -f ${1}.asc ] && {
        KEY=$(gpg --list-packets ${1}.asc | grep ':signature packet:' | grep -oE '[^ ]+$')
        gpg --list-keys --with-colons | grep "^[ps]ub:" | cut -d: -f5 | grep -q ${KEY} || \
            gpg --keyserver hkps://pgp.mit.edu:443 --recv-key ${KEY} || return 1;
        gpg --verify ${1}.asc || return 1;
    }
    tar xf ${1} || return 1
    [ -d ${DIR} ] || return 1
    chmod -R go-rwxs ${DIR}
    chown -R root:root ${DIR}
    rm -f ${1} ${1}.asc ${1}.sig
    cd ${DIR}
}

umask 077
set -o vi

[ "$TERM" != "dumb" ] && alias ls='ls --color=auto'

alias diff='colordiff'
alias cls='clear'
alias grpe='grep'
alias vi='vim'
alias ..='cd ..'

[ -f ~/.git-completion.bash ] && . ~/.git-completion.bash
[ -f ~/.git-flow-completion.bash ] && . ~/.git-flow-completion.bash

export EDITOR=/usr/bin/vim

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]
then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

title $(whoami)@$(hostname)
