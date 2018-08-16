"Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
setlocal omnifunc=necoghc#omnifunc

let g:ghci_command = "stack repl"
let g:haskellmode_completion_ghc = 0
nnoremap <silent><buffer> git :GhcModTypeInsert<CR>
nnoremap <silent><buffer> gfs :GhcModSplitFunCase<CR>
nnoremap <silent><buffer> gtt :GhcModType<CR>
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
nnoremap <buffer><silent> gl<space> :call ToggleLocationList()
nnoremap <buffer><silent> glc :sign unplace *
" nnoremap <buffer> gll :Neomake
" autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
" nmap <silent><buffer> g<space> vii<ESC>:silent!'<,'> EasyAlign /->/<CR>

function CheckIfFileExists(filename)
    if filereadable(a:filename)
        return 1
    endif
    return 0
endfunction

if (CheckIfFileExists("./stack.yaml") == 1)
    let g:ale_linters = { 'haskell': ['hlint', 'hdevtools','stack-build', 'stack-ghc'], }
endif
