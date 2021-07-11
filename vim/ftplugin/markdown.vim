set colorcolumn=80
set expandtab
set shiftwidth=2
set tabstop=2
set textwidth=80

syn match MdTodoOpen /* \[ \]/ conceal cchar=o
syn match MdTodoClose /* \[x\]/ conceal cchar=✔
hi clear Conceal

set formatoptions=tcroqwanlj
set comments=fb:*,fb:-,fb:+,fb:1.,n:> 
