inoreab <buffer> int Int
inoreab <buffer> integer Integer
inoreab <buffer> string String
inoreab <buffer> double Double
inoreab <buffer> float Float
inoreab <buffer> true True
inoreab <buffer> false False
inoreab <buffer> just Just
inoreab <buffer> nothing Nothing

iabbrev alph α
iabbrev beta β
iabbrev lmda λ

" We're going to use neomake instead of ale for haskell
let g:ale_enabled = 0

" haskell-vim settings
let g:haskell_enable_quantification   = 1 " to enable highlighting of `forall`
let g:haskell_enable_recursivedo      = 1 " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax      = 1 " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles        = 1 " to enable highlighting of type roles
let g:haskell_enable_static_pointers  = 1 " to enable highlighting of `static`
let g:haskell_backpack                = 1 " to enable highlighting of backpack keywords
let g:haskell_indent_if               = 3
let g:haskell_indent_case             = 2
let g:haskell_indent_let              = 4
let g:haskell_indent_where            = 6
let g:haskell_indent_before_where     = 2
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_do               = 3
let g:haskell_indent_in               = 1
let g:haskell_indent_guard            = 2
