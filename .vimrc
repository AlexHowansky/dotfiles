call pathogen#infect()
call pathogen#helptags()

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

" but tab indent PHP
autocmd FileType php set noexpandtab

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
"highlight clear SignColumn
highlight SignColumn ctermbg=black
