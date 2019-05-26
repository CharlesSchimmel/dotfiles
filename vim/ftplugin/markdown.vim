iabbrev cmk ✓
iabbrev cmkb ✔
iabbrev xmk ✗
iabbrev xmkb ✘

set textwidth=80
set formatoptions=jcqorlt

syn match MdTodoOpen /* \[ \]/ conceal cchar=o
syn match MdTodoClose /* \[x\]/ conceal cchar=✔
hi clear Conceal
