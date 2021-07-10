iabbrev cmk ✓
iabbrev cmkb ✔
iabbrev xmk ✗
iabbrev xmkb ✘

syn match MdTodoOpen /* \[ \]/ conceal cchar=o
syn match MdTodoClose /* \[x\]/ conceal cchar=✔
hi clear Conceal

set textwidth=80
set formatoptions=jcqorltwan
set shiftwidth=2
set tabstop=2
