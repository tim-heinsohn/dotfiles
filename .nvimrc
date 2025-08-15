" PROJECT
let g:project_path = substitute(expand("`pwd`"), '/\$', '', '')

" load default session when not in diff mode
if !&diff
  source .vimsession
endif

" preserve buffers, history
exec "set viminfo=%,'50,<1000,s100,:50,@10,/50,n" . g:project_path . ".viminfo"

" <F10> to save & quit
exec "nmap <silent> <F10>
    \ :mksession! " . g:project_path . ".vimsession<CR>:wviminfo! " . g:project_path . ".viminfo<CR>:qa!<CR>"

" FIND FILES
" multiple pathes can be included using space as delimiter
" mapped to FZX via _g and _G
let g:fzx_search_path = ". " . g:project_path

" CODING STANDARDS
set expandtab " do use spaces instead of tabs
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Ruby
autocmd FileType ruby set shiftwidth=2
autocmd FileType ruby set softtabstop=2
autocmd FileType ruby set tabstop=2

" FILE SETTINGS
set ff=unix

" SPELL LANGUAGE
"setlocal spell spelllang=en_us
"setlocal spell spelllang=de_de
"set complete+=kspell

" COLORSCHEME
" ...
