" set formatoptions=jcqorltwan " vimwiki plugin overrides this to jqltwan
set colorcolumn=80
set expandtab
set shiftwidth=4
set tabstop=4
set textwidth=80

" Complete path relative to current buffer
inoremap <expr> <c-x><m-c-f> fzf#vim#complete#path(
    \ "find . -path '*/\.*' -prune -o -print \| sed '1d;s:^..::'",
    \ fzf#wrap({'dir': expand('%:p:h')}))

function! HandleFZF(file)
    let basename_extensionless = fnamemodify(a:file, ":r:t")
    let clean_spaces = substitute(basename_extensionless, "\\", "", "g")
    let no_prefix = substitute(clean_spaces, "^[l-z][0-9a-b][0-9a-z] ", "", "")
    let titled = substitute(no_prefix, "\\<\\w", "\\U\\0", "g")
     " Insert the markdown link to the file in the current buffer
    let mdlink = "[[".clean_spaces."|".titled."]]"
    put=mdlink
endfunction

command! -nargs=1 HandleFZF :call HandleFZF(<f-args>)
inoremap <c-x><c-f> :call fzf#run(fzf#wrap({'sink': 'HandleFZF'}))<cr>
inoremap <c-x><c-g> :call fzf#run(fzf#wrap({
    \'sink': 'HandleFZF', 
    \'prefix': '^.*$',
    \'source': 'rg -n ^ --color always',
    \'options': '--ansi --delimiter : --nth 3..' }))<cr>

nnoremap <c-x><c-f> :call fzf#run(fzf#wrap({'sink': 'HandleFZF'}))<cr>
nnoremap <c-x><c-g> :call fzf#run(fzf#wrap({
    \'sink': 'HandleFZF', 
    \'prefix': '^.*$',
    \'source': 'rg -n ^ --color always',
    \'options': '--ansi --delimiter : --nth 3..' }))<cr>

