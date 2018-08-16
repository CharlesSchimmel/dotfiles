call plug#begin('~/.vim/plugged')

" The Pope's Holy Plugins
Plug 'tpope/vim-commentary'            " use gcc to comment lines
Plug 'tpope/vim-fugitive'              " git integration
Plug 'tpope/vim-repeat'                " more advanced dot repetition
Plug 'tpope/vim-sleuth'                " infers tab/space expansion from file
Plug 'tpope/vim-surround'              " wrap stuff with ([{ etc
Plug 'tpope/vim-vinegar'               " enhances netrw

" Navigation/File Management
Plug 'junegunn/fzf'                    " fuzzy file finder
            \ , { 'dir':'~/.fzf', 'do':'./install --bin' }
Plug 'junegunn/fzf.vim'                " fuzzy file finder

" IDE ish
Plug 'w0rp/ale'                        " Linting and such

" QoL
Plug 'airblade/vim-gitgutter'          " Show git changes (+-~) in file
Plug 'benmills/vimux'                  " Easily update tmux panes from vim
Plug 'junegunn/vim-easy-align'         " Align stuff (like these comments)
Plug 'vim-airline/vim-airline'         " Betterer statusline
Plug 'vim-airline/vim-airline-themes'  " WISL
Plug 'vim-scripts/restore_view.vim'    " restores cursor position and folds

" Filetype Specific
"   Typescript
Plug 'leafgarland/typescript-vim'      " Typescript syntax
            \, { 'for': 'typescript' }

"   Haskell
Plug 'parsonsmatt/intero-neovim'       " OTF type-checking and more
            \, { 'for': 'haskell' }
Plug 'neomake/neomake'                 " Really only for intero-neovim
            \, { 'for': 'haskell' }

call plug#end()                        " required

filetype plugin indent on
set number
set ruler
set showbreak=+++
set textwidth=0
set showmatch
set visualbell
set t_vb=
set laststatus=2                                " Show statusbar in all panes
set undolevels=1000
set undofile
set undodir=$HOME/.vim/vimundo/
set hidden                                      " Prevents from exiting w/o saving. (q!)
set hlsearch
set smartcase ignorecase
set incsearch
set autoindent
set smarttab
set expandtab
set backspace=indent,eol,start
set wrap linebreak nolist                       " softwrap
set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:× list
                                                " Show whitepsace

" wild/globbing
set wildmode=list:longest,full
set wildmenu
set wildignorecase

set nrformats=                                  " Ignores non-decimal number formats (hint courtesy of practical vim, pg 21
map <C-l> <ESC>:tabn <CR>
map <C-h> <ESC>:tabp <CR>
map <C-j> <ESC>:bn! <CR>
map <C-k> <ESC>:bp! <CR>
map <C-_> <ESC>:b# <CR>

set bg=light
let g:airline_theme='sol'
" colorscheme default
syntax on

" FZF
nnoremap <C-f> :GFiles<CR>
autocmd! FileType fzf
autocmd FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
"   Use :Fzfc to view changed git files
command! Fzfc call fzf#run(fzf#wrap( {'source': 'git ls-files --exclude-standard --others --modified'}))

" ALE
map <Leader>] :ALENext<cr>
map <Leader>[ :ALEPrevious<cr>

" neomake
map <Leader>] :lnext<cr>
map <Leader>[ :lprev<cr>
map <Leader>o :lopen<cr>

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
