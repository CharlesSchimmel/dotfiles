set nocompatible " must be first

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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'vimwiki/vimwiki'

" QoL
Plug 'airblade/vim-gitgutter'          " Show git changes (+-~) in file
Plug 'christoomey/vim-tmux-navigator'  " Navigate vim/tmux panes
Plug 'junegunn/goyo.vim'               " Center the text area
Plug 'junegunn/vim-easy-align'         " Align stuff (like these comments)
Plug 'vim-airline/vim-airline'         " Betterer statusline
Plug 'vim-airline/vim-airline-themes'  " WISL
Plug 'vim-scripts/restore_view.vim'    " restores cursor position and folds

" Candy
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'joshdick/onedark.vim'
Plug 'romainl/apprentice'
Plug 'sainnhe/sonokai'

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
set t_vb=                        " disable visual bell
set t_Co=256                     " Still necessary?

colorscheme tokyonight
let g:tokyonight_style = 'storm' " available: night, storm
let g:tokyonight_enable_italic = 1

" === Bindings ===
" create file under cursor if it does not exist
noremap <leader>gf :e <cfile><cr>

" Move through tabs/buffers with grace
map <C-l> <ESC>:tabn <CR>
map <C-h> <ESC>:tabp <CR>
map <C-j> <ESC>:bn! <CR>
map <C-k> <ESC>:bp! <CR>

if &diff
    nmap <leader>gr :diffg REMOTE<cr>
    nmap <leader>gl :diffg LOCAL<cr>
endif

" === Plugin Settings ===
" close netrw buffers
autocmd FileType netrw setl bufhidden=wipe

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

source $HOME/.vim/plugin-settings/vimwiki.vim
source $HOME/.vim/plugin-settings/tmux-navigator.vim
source $HOME/.vim/plugin-settings/coc.vim
source $HOME/.vim/plugin-settings/airline.vim
source $HOME/.vim/plugin-settings/fzf.vim

" removed 20210711
" set nolist                                      " ???
" highlight Search ctermbg=grey
" set directory=$HOME/.vim/swapfiles//
