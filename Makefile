install: update
	cp -i .*.bash ~
	cp -r .gitconfig .inputrc .ssh .vim* .config ~
	chmod go-rwx ~/.ssh/*

update: init vim completion powerline

init:
	git submodule init
	git submodule update

vim: 
	mkdir -p ~/.vim/autoload
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

completion:
	curl -LSso ~/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
	curl -LSso ~/.git-flow-completion.bash https://raw.githubusercontent.com/bobthecow/git-flow-completion/master/git-flow-completion.bash

powerline: init
	mkdir -p ~/bin
	cp config.py powerline-shell/
	(cd powerline-shell && ./install.py)
	cp powerline-shell/powerline-shell.py ~/bin
