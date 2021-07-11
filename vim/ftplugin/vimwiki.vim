
" These are copied from the markdown ftplugin
set colorcolumn=80
set textwidth=80
set shiftwidth=4
set tabstop=4
set expandtab
set formatoptions=tcrqwanlj

" Complete path relative to current buffer
inoremap <expr> <c-x><m-c-f> fzf#vim#complete#path(
    \ "find . -path '*/\.*' -prune -o -print \| sed '1d;s:^..::'",
    \ fzf#wrap({'dir': expand('%:p:h')}))
