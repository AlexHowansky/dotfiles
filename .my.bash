function color()
{
    case ${1} in
        'black') CODE='0;30' ;;
        'red') CODE='0;31' ;;
        'green') CODE='0;32' ;;
        'yellow') CODE='0;33' ;;
        'blue') CODE='0;34' ;;
        'purple') CODE='0;35' ;;
        'cyan') CODE='0;36' ;;
        'light_gray') CODE='0;37' ;;
        'dark_gray') CODE='1;30' ;;
        'bold_red') CODE='1;31' ;;
        'bold_green') CODE='1;32' ;;
        'bold_yellow') CODE='1;33' ;;
        'bold_blue') CODE='1;34' ;;
        'bold_purple') CODE='1;35' ;;
        'bold_cyan') CODE='1;36' ;;
        'white') CODE='1;37' ;;
        *) return ;;
    esac
    echo -ne "\[\033[${CODE}m\]"
}

function cd()
{
    builtin cd "${@}"

    C_PUNC="$(color light_gray)"
    C_USER="$(color bold_green)"
    C_HOST="$(color bold_green)"
    C_DIR="$(color bold_yellow)"
    C_GITB="$(color cyan)"
    C_GITM="$(color red)"

    BRANCH=$(/usr/bin/env git branch 2>/dev/null | grep '^*' | cut -c3-)
    if [ "${BRANCH}" == "" ]
    then
        export PS1="${C_PUNC}[${C_USER}\u${C_PUNC}@${C_HOST}\H${C_PUNC}] ${C_DIR}\w${C_PUNC}: "
    else
        if [ "${BRANCH}" == "master" ]
        then
            export PS1="${C_PUNC}[${C_USER}\u${C_PUNC}@${C_HOST}\H${C_PUNC}] ${C_DIR}\w ${C_PUNC}[${C_GITM}${BRANCH}${C_PUNC}]: "
        else
            export PS1="${C_PUNC}[${C_USER}\u${C_PUNC}@${C_HOST}\H${C_PUNC}] ${C_DIR}\w ${C_PUNC}[${C_GITB}${BRANCH}${C_PUNC}]: "
        fi
    fi
}

function git()
{
    /usr/bin/env git "${@}"
    cd .
}

function ga()
{
    git add ${*}
}

function gc()
{
    git commit ${*}
}

function gd()
{
    git diff ${*}
}

function gdc()
{
    git diff --cached ${*}
}

function gl()
{
    git log --name-status ${*}
}

function gp()
{
    git pull
}

function gs()
{
    git status
}

function gf()
{
	git find ${*}
}

function gcp()
{
    git cherry-pick -n -x ${*}
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

cd .
