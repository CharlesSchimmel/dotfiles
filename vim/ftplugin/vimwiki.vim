set colorcolumn=80
set textwidth=80
" set formatoptions=jcqorltwan " vimwiki plugin overrides this to jqltwan
set shiftwidth=4
set tabstop=4
set expandtab

nnoremap _ <Plug>VinegarUp

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

