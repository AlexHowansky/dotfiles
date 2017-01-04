call pathogen#infect()
call pathogen#helptags()

" force sensible to run first so we can override it
runtime! plugin/sensible.vim

syntax enable

" for use with the default syntax highlighting
" comment these out if using a local color scheme
hi comment ctermfg=darkgrey
hi search ctermfg=black ctermbg=yellow

" space indent everything
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" ignore folding
set nofoldenable

" auto-start next line with comment header
set formatoptions+=or

" remember cursor position
set viminfo='10,\"100,:20,%,n~/.viminfo

" airline
if v:version >= 702
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1
endif

" gitgutter
hi SignColumn ctermbg=black

" JSON
let g:vim_json_syntax_conceal = 0
