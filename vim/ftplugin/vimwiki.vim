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

" search for files with FZF and insert them as links
function! HandleFZF(file)
  set fo-=ta
  let basename_extensionless = fnamemodify(a:file, ":t:r")
  let meta_title = matchstr(readfile(expand(a:file)), '^title: .\+$') 
  let clean_spaces = substitute(basename_extensionless, "\\", "", "g")
  let no_prefix = substitute(clean_spaces, "^[l-z][a-c0-9][a-z0-9] ", "", "")
  if (empty(meta_title))
    let titled = substitute(no_prefix, "\\(\\<\\w\\)", "\\U\\1", "g")
  else
    let titled = substitute(meta_title, "title: ", "", "g")
  endif
  if (expand('%:p:h') =~ 'diary') " extremely dirty check to see if we're in the diary dir
      let clean_spaces = '../zk/'.clean_spaces
  endif
  let confirm_title = input('Link Title: ', titled)
  let mdlink = "[".confirm_title."](<".clean_spaces.">)"
  "put=mdlink
  exe "normal! a" . mdlink . "\<Esc>"
  set fo+=ta
  write
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
  " let save_pos = getpos('.')

  call inputsave()
  let name = input('Link title: ')
  if (!empty(name))
    let date = system('/home/schimmch/.scripts/date62.sh')
    let titled=substitute(name, "\\<\\w", "\\U\\0", "g")
    let sanitized=substitute(name, "[^a-zA-Z0-9-_ ]", "", "g")
    let filename = date.' '.sanitized
    if (expand('%:p:h') =~ 'diary') " extremely dirty check to see if we're in the diary dir
        let filename = '../zk/'.filename
    endif
    let wholething = "[".titled."](<".filename.">)"
    call inputrestore()
    exe "normal! a" . wholething
    set fo+=ta
    write
  endif
endfunction

inoremap <c-l> <esc>:call MkNewLink()<cr>
nnoremap <c-n><c-l> :call MkNewLink()<cr>

hi link VimwikiLink blue

:GitGutterBufferDisable
