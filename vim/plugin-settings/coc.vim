" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>di <Plug>(coc-diagnostic-info)
nmap <silent> <leader>dn <Plug>(coc-diagnostic-next)
nmap <silent> <leader>dp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>cr <Plug>(coc-rename)
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

set updatetime=300
set signcolumn=yes
let g:coc_node_path="/home/schimmch/.nvm/versions/node/v10.16.3/bin/node"
