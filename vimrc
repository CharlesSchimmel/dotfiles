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
set nrformats=                                  " Ignores non-decimal number formats (hint courtesy of practical vim, pg 21

" wild/globbing
set wildmode=list:longest,full
set wildmenu
set wildignorecase

map <C-l> <ESC>:tabn <CR>
map <C-h> <ESC>:tabp <CR>
map <C-j> <ESC>:bn! <CR>
map <C-k> <ESC>:bp! <CR>
map <C-p> <ESC>:b# <CR>

set bg=light
" colorscheme default
syntax on

set formatoptions=jcqorl
