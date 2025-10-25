" FZF
" Install bat, rg, and fd!
" show a preview window to the right of the file list
let g:fzf_preview_window = ['down:35%', 'ctrl-/']

" take up less space
let g:fzf_layout = { 'window': { 'width': 0.7, 'height': 0.6 } }
nnoremap <C-p> :GFiles<CR>
nnoremap <C-y> :Files<CR>
" nnoremap <C-y> command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
nnoremap <C-g> :Rg<CR>
nnoremap <C-b> :Buffers<CR>
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')

" Word completion with custom spec with popup layout option
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1 }})

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.fzf#shellescape(<q-args>),
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" line completion from the entire git repo?

imap <c-x><c-l> <plug>(fzf-complete-line)
imap <c-x><c-f> <plug>(fzf-complete-path)

autocmd! FileType fzf
autocmd FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
"   Use :Fzfc to view changed git files
command! Fzfc call fzf#run(fzf#wrap( {'source': 'git ls-files --exclude-standard --others --modified'}))

" Use FZF to find a file and insert it
" https://www.edwinwenink.xyz/posts/48-vim_fast_creating_and_linking_notes/
