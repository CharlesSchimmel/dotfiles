" Breaks
setlocal showbreak=+++
setlocal textwidth=100                       " Newline after 100 chars
setlocal autoindent
setlocal colorcolumn=0
setlocal spell
setlocal shiftwidth=4
iabbrev -> \rightarrow

nnoremap <F5> :!pandoc % -o /tmp/test.pdf<CR>
