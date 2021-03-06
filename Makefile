install: submodules
	cp -i .my.bash ~
	cp -r .gitconfig .inputrc .ssh .vim* .config ~
	chmod go-rwx ~/.ssh/*

submodules: init vim completion powerline

init:
	git submodule init
	git submodule update

vim: init
	mkdir -p ~/.vim/autoload
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

completion:
	curl -LSso ~/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
	curl -LSso ~/.git-flow-completion.bash https://raw.githubusercontent.com/bobthecow/git-flow-completion/master/git-flow-completion.bash

powerline: init
	mkdir -p ~/.config/powerline-shell/
	cp config.json ~/.config/powerline-shell/
	(cd powerline-shell && ./setup.py install --user)

update:
	git submodule foreach git pull origin master
