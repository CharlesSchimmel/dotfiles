" set formatoptions=jcqorltwan " vimwiki plugin overrides this to jqltwan
set colorcolumn=80
set expandtab
set shiftwidth=4
set tabstop=4
set textwidth=80

au BufNewFile ~/zk/*.md 0r !~/zk/template.sh '%'
au BufNewFile ~/zk/*.md ks|:normal ggzf4j|'s

" from the helpfiles 'skeleton template'
autocmd BufWritePre,FileWritePre *.md   ks|call LastMod()|'s
fun LastMod()
  if line("$") > 10
    let l = 10
  else
    let l = line("$")
  endif
  exe "1," . l . "g/updated: /s/updated: .*/updated: " .
  \ strftime("%Y-%m-%d")
endfun

" Complete path relative to current buffer
inoremap <expr> <c-x><m-c-f> fzf#vim#complete#path(
    \ "find . -path '*/\.*' -prune -o -print \| sed '1d;s:^..::'",
    \ fzf#wrap({'dir': expand('%:p:h')}))
