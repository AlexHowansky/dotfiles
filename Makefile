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
	curl -LSso ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim

completion:
	curl -LSso ~/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
	bash -c '[ "`type -t composer`" == "file" ] && composer completion > ~/.composer-completion.bash || true'

powerline: init
	mkdir -p ~/.config/powerline-shell/
	cp config.json ~/.config/powerline-shell/
	(cd powerline-shell && ./setup.py install --user)

update: init
	git submodule update --recursive --remote --init
