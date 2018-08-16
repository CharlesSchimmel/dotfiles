inoreab <buffer> int Int
inoreab <buffer> integer Integer
inoreab <buffer> string String
inoreab <buffer> double Double
inoreab <buffer> float Float
inoreab <buffer> true True
inoreab <buffer> false False
inoreab <buffer> just Just
inoreab <buffer> nothing Nothing
inoreab <buffer> io IO ()

iabbrev alph α
iabbrev beta β
iabbrev lmda λ

" We're going to use neomake instead of ale for haskell
let g:ale_enabled = 0

" Intero
nnoremap <silent> <leader>io :InteroOpen<CR>
nnoremap <silent> <leader>ih :InteroHide<CR>
nnoremap <silent> <leader>ie :InteroEval<CR>

au BufWritePost *.hs InteroReload

let g:intero_type_on_hover = 1
