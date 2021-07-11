" VimWiki
let g:vimwiki_auto_header = 1
" to replace spaces with underscores: 'links_space_char': '_'
let g:vimwiki_list = [{'path': '~/notes/', 'syntax': 'markdown', 'ext': '.md'}]
" By default VimWiki will interprate all .md files as VimWiki files. This disables that.
let g:vimwiki_global_ext = 0 
" Always append .md extension when creating new items or filling existing items
" let g:vimwiki_markdown_link_ext = 1
