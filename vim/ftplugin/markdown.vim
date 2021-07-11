iabbrev lchk ✓
iabbrev chk ✔
iabbrev cmk ✔
iabbrev lxmk ✗
iabbrev xmk ✘
iabbrev upr ↑
iabbrev downr ↓
iabbrev rightr →
iabbrev leftr ←
iabbrev subsetsym ⊆
iabbrev supersetsym ⊇
iabbrev elem ∈
iabbrev nelem ∉
iabbrev union ∪

set colorcolumn=80
set textwidth=80
set shiftwidth=2
set expandtab

" j: Where it makes sense, remove a comment leader when joining lines
" a: Automatic formatting of paragraphs. Every time text is inserted or deleted 
" the paragraph will be reformatted.
" t: auto-wrap text using textwidth
" c: Auto-wrap comments using textwidth, inserting the current comment
   " leader automatically.
" q: Allow formatting of comments with "gq".
" l: Long lines are not broken in insert mode: When a line was longer than
   " 'textwidth' when the insert command started, Vim does not
   " automatically format it.
" o: Automatically insert the current comment leader after hitting 'o' or
   " 'O' in Normal mode.
" r: Automatically insert the current comment leader after hitting
   " <Enter> in Insert mode.
" w: Trailing white space indicates a paragraph continues in the next line.
   " A line that ends in a non-white character ends a paragraph.
" n: When formatting text, recognize numbered lists.
" set formatoptions=jatcqlrwn
set formatoptions=tcrqwanlj
set comments=fb:*,fb:-,fb:+,fb:1.,n:> 

" this is a long comment this is a long comment this is a long comment this is a 
" long comment

set noautoindent

" Changed from:
" ^\s*\%(\(-\|\*\|+\)\|\(\C\%(\d\+\.\)\)\)\s\+\%(\[\([ .oOX-]\)\]\s\)\?
" But that was causing weird formatting when parenthesis were inserted
set formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^\\s*[-*+]\\s\\+\\\|^\\[^\\ze[^\\]]\\+\\]:
