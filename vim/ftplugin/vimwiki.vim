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
    set fo-=ta
    let basename_extensionless = fnamemodify(a:file, ":t:r")
    let clean_spaces = substitute(basename_extensionless, "\\", "", "g")
    let no_prefix = substitute(clean_spaces, "^[l-z][0-9a-c][0-9a-z] ", "", "")
    let titled = substitute(no_prefix, "\\(\\<\\w\\)", "\\U\\1", "g")
    let mdlink = "[[".clean_spaces."|".titled."]]"
    "put=mdlink
    exe "normal! a" . mdlink . "\<Esc>"
    set fo+=ta
endfunction

command! -nargs=1 HandleFZF :call HandleFZF(<f-args>)
inoremap <c-x><c-f> <esc>:call fzf#run(fzf#wrap({'sink': 'HandleFZF'}))<cr>
inoremap <c-x><c-g> <esc>:call fzf#run(fzf#wrap({
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

" " grep for a H1 Header in the first 6 lines and, if found, fold everything
" " before it
" let [lnum, colnum] = searchpos('^# ', '', 6)
" exe '0,6foldo'
" exe '0,'.(lnum-1).'fold'

function! MkNewLink()
  " fo-=t might suffice
  set fo-=ta
  let curline = getline('.')
  call inputsave()
  let name = input('Link title: ')
  let date = system('/home/schimmch/.scripts/date62.sh')
  let titled=substitute(name, "\\<\\w", "\\U\\0", "g")
  let filename = date.' '.name
  let wholething = '[['.filename.'|'.titled.']]'
  call inputrestore()
  exe "normal! a" . wholething
  set fo+=ta
endfunction

inoremap <c-x><c-l> <esc>:call MkNewLink()<cr>
nnoremap <c-x><c-l> :call MkNewLink()<cr>
