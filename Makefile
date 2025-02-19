install: submodules
	cp -i .my.bash ~
	cp -r .gitconfig .inputrc .ssh .vim* .config ~
	chmod go-rwx ~/.ssh/*

submodules: init vim completion starship

init:
	git submodule init
	git submodule update

vim: init
	mkdir -p ~/.vim/autoload
	curl -LSso ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim

completion:
	curl -LSso ~/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
	bash -c '[ "`type -t composer`" == "file" ] && composer completion > ~/.composer-completion.bash || true'

starship:
	bash -c '[ "`type -t starship`" == "file" ] || curl -sS https://starship.rs/install.sh | sh'

update: init
	git submodule update --recursive --remote --init
