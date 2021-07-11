" VimWiki
let g:vimwiki_auto_header = 1
" to replace spaces with underscores: 'links_space_char': '_'
let g:vimwiki_list = [{'path': '~/notes/', 'syntax': 'markdown', 'ext': '.md'}]
" By default VimWiki will interprate all .md files as VimWiki files. This disables that.
let g:vimwiki_global_ext = 0 
" Always append .md extension when creating new items or filling existing items
" let g:vimwiki_markdown_link_ext = 1

" 0r: pipe the file name into the script and generate a template
au BufNewFile ~/notes/*.md 0r !~/zk/template.sh '%'
au BufNewFile ~/notes/*.md ks|:normal ggzf4j|'s

" from the helpfiles 'skeleton template'
" if a file has 'updated:' in the first lines, update that with today's date
autocmd BufWritePre,FileWritePre ~/notes/*.md   ks|call LastMod()|'s
fun LastMod()
    if line("$") > 5
        let l = 5
    else
        let l = line("$")
    endif
    exe "1," . l . "g/updated: /s/updated: .*/updated: " .
    \ strftime("%Y-%m-%d")
endfun
