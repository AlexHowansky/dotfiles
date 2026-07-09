call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'henrik/vim-indexed-search'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'vim-polyglot/vim-polyglot'
call plug#end()

" We need to explicitly set colorscheme to default to ensure that it activates
" after syntax has defined the highlight groups.
syntax enable
colorscheme default

" Override the default theme highlighting. Probably comment these out if using
" a different color theme.
highlight Comment ctermfg=DarkGray
highlight Search ctermfg=Black ctermbg=Yellow
highlight SignColumn ctermbg=233

" Apply sh highlighting to all env file sub-types.
autocmd BufRead,BufNewFile .env.* set filetype=sh

" Space indent everything.
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Disable folding.
set nofoldenable

" Remember the cursor position.
set viminfo='10,\"100,:20,%,n~/.viminfo

" Remember undos.
set undofile
set undodir=~/.vim/undo

" Start the new line with a comment if we're on a comment line and we start a
" new line.
set formatoptions+=or

" Don't indent comments in YAML files.
autocmd FileType yaml,yml setlocal indentkeys-=0#

" Always show quotes in JSON files.
let g:vim_json_syntax_conceal = 0

" Airline config.
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
