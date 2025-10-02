function _update_ps1() {
    PS1=$(~/.local/bin/powerline-shell $?)
}

function cb() {
    composer bump
}

function ci() {
    composer install ${*}
}

function cin() {
    composer install --no-scripts ${*}
}

function co() {
    composer outdated ${*}
}

function cu() {
    composer update ${*}
}

function cud() {
    composer update --dry-run ${*}
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
    git log --topo-order --name-status ${*}
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
        echo "Define GSU_REPOS to contain a space-separated list of your desired"
        echo "repositories for reporting, these will be prefixed with '~/git/'."
        return
    fi
    declare -A DAYS
    DAYS["Mon"]=3
    DAYS["Tue"]=1
    DAYS["Wed"]=1
    DAYS["Thu"]=1
    DAYS["Fri"]=1
    DAYS["Sat"]=1
    DAYS["Sun"]=2
    pushd . >/dev/null
    for REPO in ${GSU_REPOS}
    do
        cd ~/git/${REPO}
        basename ${REPO}
        git pull --quiet
        git standup -d ${1:-${DAYS[$(date +%a)]}}
        echo
    done
    popd >/dev/null
}

function gu() {
    git reset --soft HEAD~1
}

function phpv() {
    sudo -- sh -c "
        for P in php php-config phpize phar phar.phar
        do
            update-alternatives --set \$P /usr/bin/\${P}${1}
        done >/dev/null
        php -v
    "
}

function title() {
    echo -en "\e]2;${1}\a"
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

if [ "$TERM" != "dumb" ]
then
    alias ls='ls --color=auto'
    title $(whoami)@$(hostname)
fi

if [ -n "$(type -p diff-so-fancy)" ]
then
    function dsf() {
        /bin/diff -u $1 $2 | diff-so-fancy
    }
    alias diff='dsf'
else
    if [ -n "$(type -p colordiff)" ]
    then
        alias diff='colordiff'
    fi
fi

alias cls='clear'
alias grpe='grep'
alias php74='phpv 7.4'
alias php80='phpv 8.0'
alias php81='phpv 8.1'
alias php82='phpv 8.2'
alias php83='phpv 8.3'
alias php84='phpv 8.4'
alias php85='phpv 8.5'
alias vi='vim'
alias ..='cd ..'

[ -f ~/.git-completion.bash ] && . ~/.git-completion.bash
[ -f ~/.composer-completion.bash ] && . ~/.composer-completion.bash

export EDITOR=/usr/bin/vim

if [ -n "$(type -p starship)" ]
then
    eval "$(starship init bash)"
else
    if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]
    then
        PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
    fi
fi
