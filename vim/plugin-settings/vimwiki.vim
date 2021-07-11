let g:vimwiki_list = [
    \ {'path': '~/zk', 'syntax': 'markdown', 'ext': 'md'},
    \ {'path': '~/infinite-jest/', 'syntax': 'markdown', 'ext': '.md'}, 
    \ {'path': '~/dox/sync-notes/', 'syntax': 'markdown', 'ext': 'md'}]
" Without this option vimwiki will intereprate all .md files as vimwiki
let g:vimwiki_global_ext = 0
" Title file with an H1 with the file name on new file
" let g:vimwiki_auto_header = 1

" 0r: pipe the file name into the script and generate a template
au BufNewFile ~/zk/*.md 0r !~/zk/template.sh '%'
au BufNewFile ~/zk/*.md ks|:normal ggzf4j|'s

" from the helpfiles 'skeleton template'
" if a file has 'updated:' in the first lines, update that with today's date
autocmd BufWritePre,FileWritePre ~/zk/*.md   ks|call LastMod()|'s
fun LastMod()
    if line("$") > 5
        let l = 5
    else
        let l = line("$")
    endif
    exe "1," . l . "g/updated: /s/updated: .*/updated: " .
    \ strftime("%Y-%m-%d")
endfun
