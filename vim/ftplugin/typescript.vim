set expandtab
set shiftwidth=2
set softtabstop=2
let g:ale_fixers = { 'typescript': ['tslint'], }
let g:ale_linters = { 'typescript': ['tslint', 'eslint'], }
set colorcolumn=120

" indent chained method calls on newlines
" ex foo
"      .bar()
"      .baz()
setlocal indentkeys+=0

set number
set nocursorline
