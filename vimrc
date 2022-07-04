set nocompatible " must be first

call plug#begin('~/.local/share/nvim/plugged')

" The Pope's Holy Plugins
Plug 'tpope/vim-commentary'            " use gcc to comment lines
Plug 'tpope/vim-repeat'                " more advanced dot repetition
Plug 'tpope/vim-sleuth'                " infers tab/space expansion from file
Plug 'tpope/vim-surround'              " wrap stuff with ([{ etc
Plug 'tpope/vim-vinegar'               " enhances netrw

call plug#end()                 " required

set autoindent                  " Copy indent from current line when starting a new line
set backspace=indent,eol,start  " Backspace whenever
set expandtab                   " Spaces not tabs
set formatoptions=jcqorl        " Set formatting default
set hidden                      " Allow vim to hide modified buffers
set hlsearch                    " Highlight search results
set ignorecase                  " Disregard case when searching
set incsearch                   " Highlight as you type your search
set laststatus=2                " Show statusbar in all panes
set linebreak                   " Try to wrap nicely
set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:× list
set nrformats=                  " Ignores non-decimal number formats (courtesy of practical vim, pg 21
set number                      " Line nums in gutter
set ruler                       " Show cursor pos in statusline
set shiftround                  " Round indent to nearest shiftwidth multiple
set shiftwidth=4                " Spaces for each indent
set showbreak=+++               " When softwrapping prepend wrapped lines with +++
set showmatch                   " Highlight matching brace
set smartcase                   " Case-sensitive if search contains Upper
set smartindent                 " Infer indentation on newlines
set smarttab                    " Treat space chunks like tabs
set softtabstop=4               " Space:tab count when inserting/bsing
set tabstop=4                   " Space:tab count when retabbing
set textwidth=0                 " Don't break lines on words
set undodir=$HOME/.vim/vimundo/ " Store undo files here
set undofile                    " Persist undo across sessions
set undolevels=1000
set visualbell                  " Flash terminal on bell
set wildignorecase
set wildmenu
set wildmode=longest,list,full
set wrap                        " Softwrap long lines

filetype plugin indent on
syntax on

" === Colors ===
set bg=dark
set termguicolors

" === Bindings ===
" create file under cursor if it does not exist
nnoremap <leader>gf :e <cfile><cr>

" Move through tabs/buffers with grace
map <C-l> <ESC>:tabn <CR>
map <C-h> <ESC>:tabp <CR>
map <C-j> <ESC>:bn! <CR>
map <C-k> <ESC>:bp! <CR>
map <C-p> <ESC>:b# <CR>
