function _update_ps1() {
    export PS1="$(~/bin/powerline-shell.py --cwd-mode plain --mode patched --colorize-hostname $? 2> /dev/null)"
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

function gb()
{
    git branch ${*}
}

function gc()
{
    git commit ${*}
}

function gco()
{
    git checkout ${*}
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

function unpack()
{
    [ -f ${1}.asc ] && { gpg --verify ${1}.asc || return 1; }
    [ -f ${1}.sig ] && { gpg --verify ${1}.sig || return 1; }
    tar xf ${1}
    chmod -R go-rwxs ${1%.tar.*}
    chown -R root:root ${1%.tar.*}
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
export PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
