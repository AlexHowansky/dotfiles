update:
	curl -LSso .vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
	curl -LSso .git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
	curl -LSso .git-flow-completion.bash https://raw.githubusercontent.com/bobthecow/git-flow-completion/master/git-flow-completion.bash
	git submodule init
	git submodule update

install:
	cp -r .*.bash .gitconfig .inputrc .ssh .vim* ~
