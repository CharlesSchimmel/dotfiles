" FZF
" show a preview window to the right of the file list
let g:fzf_preview_window = ['down:40%', 'ctrl-/']
" take up less space
let g:fzf_layout = { 'window': { 'width': 0.6, 'height': 0.6 } }
nnoremap <C-p> :GFiles<CR>
nnoremap <C-y> :Files<CR>
nnoremap <C-g> :Rg<CR>
nnoremap <C-b> :Buffers<CR>
inoremap <expr> <c-x><c-g> fzf#vim#complete#path('rg')
imap <c-x><c-f> <plug>(fzf-complete-path)
autocmd! FileType fzf
autocmd FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
"   Use :Fzfc to view changed git files
command! Fzfc call fzf#run(fzf#wrap( {'source': 'git ls-files --exclude-standard --others --modified'}))

" Use FZF to find a file and insert it
" https://www.edwinwenink.xyz/posts/48-vim_fast_creating_and_linking_notes/
