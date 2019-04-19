call plug#begin('~/.local/share/nvim/plugged')

" The Pope's Holy Plugins
Plug 'tpope/vim-commentary'            " use gcc to comment lines
Plug 'tpope/vim-fugitive'              " enhances netrw
Plug 'tpope/vim-repeat'                " more advanced dot repetition
Plug 'tpope/vim-sleuth'                " infers tab/space expansion from file
Plug 'tpope/vim-surround'              " wrap stuff with ([{ etc
Plug 'tpope/vim-vinegar'               " enhances netrw

" Navigation/File Management
Plug 'jremmen/vim-ripgrep'             " rg for vim
Plug 'junegunn/fzf'                    " fuzzy file finder
Plug 'junegunn/fzf.vim'                " fuzzy file finder

" IDE ish
Plug 'w0rp/ale'                        " Async Lint Engine

" QoL
Plug 'airblade/vim-gitgutter'          " Show git diffs in file
Plug 'benmills/vimux'                  " Vim + Tmux
Plug 'christoomey/vim-tmux-navigator'  " Navigate vim/tmux panes
Plug 'junegunn/vim-easy-align'         " align stuff
Plug 'vim-airline/vim-airline'         " Betterer statusline
Plug 'vim-airline/vim-airline-themes'  " WISL
Plug 'vim-scripts/restore_view.vim'    " restores cursor position and folds

" Filetype Specific
"   Haskell
Plug 'neovimhaskell/haskell-vim'       " haskell syntax highlighting and indentation
Plug 'parsonsmatt/intero-neovim'       " Ghci, type-checking, etc
            \, { 'for': 'haskell' }
Plug 'neomake/neomake'                 " lint/maker
            \, { 'for': 'haskell' }

" Typescript
Plug 'leafgarland/typescript-vim' 
            \, { 'for': 'typescript' }

" Elm
Plug 'elmcast/elm-vim'

call plug#end()                        " required

set number                             " Line nums in gutter
set ruler                              " Show cursor pos in statusline
set showmatch                          " Highlight matching brace
set visualbell
set laststatus=2                       " Show statusbar in all panes
set undolevels=1000
set undofile
set undodir=$HOME/.vim/vimundo/
set hidden                             " Allow vim to hide modified buffers
filetype plugin indent on

set hlsearch
set ignorecase
set smartcase
set incsearch                          " Highlight as you type your search

" Whitespace
set autoindent                         " Copy indent from current line when starting a new line
set shiftwidth=4                       " Spaces for each indent
set tabstop=4                          " Space:tab count when retabbing
set softtabstop=4                      " Space:tab count when inserting/bsing
set smartindent                        " Infer indentation on newlines
set smarttab                           " Treat space chunks like tabs
set expandtab                          " Spaces not tabs
set backspace=indent,eol,start         " Backspace whenever
set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:× list
set formatoptions=jcqorl
set shiftround                         " Round indent to nearest shiftwidth multiple

" Breaks
set wrap                               " Softwrap long lines
set linebreak                          " Try to wrap nicely
set showbreak=+++
set textwidth=0                        " Don't break lines on words

" Misc
set nrformats=                         " Ignores non-decimal number formats (courtesy of practical vim, pg 21

" File name tab completion
set wildmode=longest,list,full
set wildmenu
set wildignorecase

" Colors
set bg=dark
let g:airline_theme='sol'
syntax on

" fzf through Git Files
nnoremap <C-p> :GFiles<CR>
autocmd! FileType fzf
autocmd FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
"   Use :Fzfc to view changed git files
command! Fzfc call fzf#run(fzf#wrap( {'source': 'git ls-files --exclude-standard --others --modified'}))

" Move through tabs/buffers with grace
nnoremap <C-l> <ESC>:tabn <CR>
nnoremap <C-h> <ESC>:tabp <CR>
nnoremap <C-j> <ESC>:bn! <CR>
nnoremap <C-k> <ESC>:bp! <CR>

" nnoremap <C-p> <ESC>:b# <CR>


" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
" Don't forget about the ftplugins

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
nnoremap <silent> <A-l> :TmuxNavigateRight<cr>
nnoremap <silent> <A-p> :TmuxNavigatePrevious<cr>

augroup interoMaps
  au!
  " Maps for intero. Restrict to Haskell buffers so the bindings don't collide.

  " Background process and window management
  au FileType haskell nnoremap <silent> <leader>is :InteroStart<CR>
  au FileType haskell nnoremap <silent> <leader>ik :InteroKill<CR>

  " Open intero/GHCi split horizontally
  au FileType haskell nnoremap <silent> <leader>io :InteroOpen<CR>
  " Open intero/GHCi split vertically
  au FileType haskell nnoremap <silent> <leader>iov :InteroOpen<CR><C-W>H
  au FileType haskell nnoremap <silent> <leader>ih :InteroHide<CR>

  " Reloading (pick one)
  " Automatically reload on save
  au BufWritePost *.hs InteroReload
  " Manually save and reload
  au FileType haskell nnoremap <silent> <leader>wr :w \| :InteroReload<CR>

  " Load individual modules
  au FileType haskell nnoremap <silent> <leader>il :InteroLoadCurrentModule<CR>
  au FileType haskell nnoremap <silent> <leader>if :InteroLoadCurrentFile<CR>

  " Type-related information
  " Heads up! These next two differ from the rest.
  au FileType haskell map <silent> <leader>t <Plug>InteroGenericType
  au FileType haskell map <silent> <leader>T <Plug>InteroType
  au FileType haskell nnoremap <silent> <leader>it :InteroTypeInsert<CR>

  " Navigation
  au FileType haskell nnoremap <silent> <leader>jd :InteroGoToDef<CR>

  " Managing targets
  " Prompts you to enter targets (no silent):
  au FileType haskell nnoremap <leader>ist :InteroSetTargets<SPACE>
augroup END

" Enable type information on hover (when holding cursor at point for ~1 second).
let g:intero_type_on_hover = 1

" Change the intero window size; default is 10.
let g:intero_window_size = 80

" Sets the intero window to split vertically; default is horizontal
let g:intero_vertical_split = 1

" OPTIONAL: Make the update time shorter, so the type info will trigger faster.
set updatetime=1000
let g:intero_prompt_regex = '^λ '
