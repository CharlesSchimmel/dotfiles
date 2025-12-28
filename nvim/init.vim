set nocompatible " must be first

call plug#begin('~/.local/share/nvim/plugged')

" The Pope's Holy Plugins
Plug 'tpope/vim-commentary'            " use gcc to comment lines
Plug 'tpope/vim-fugitive'              " git stuff
Plug 'tpope/vim-repeat'                " more advanced dot repetition
Plug 'tpope/vim-sleuth'                " infers tab/space expansion from file
Plug 'tpope/vim-surround'              " wrap stuff with ([{ etc
Plug 'tpope/vim-vinegar'               " enhances netrw

" Navigation/File Management
Plug 'junegunn/fzf'                    " fuzzy file finder
Plug 'junegunn/fzf.vim'                " fuzzy file finder

" IDE ish
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vimwiki/vimwiki'
Plug 'sheerun/vim-polyglot'
" Plug 'junegunn/goyo.vim'               " Focused writing mode


" QoL
Plug 'airblade/vim-gitgutter'          " Show git diffs in file
Plug 'benmills/vimux'                  " Vim + Tmux
Plug 'christoomey/vim-tmux-navigator'  " Navigate vim/tmux panes
Plug 'junegunn/vim-easy-align'         " align stuff
Plug 'vim-airline/vim-airline'         " Betterer statusline
Plug 'vim-airline/vim-airline-themes'  " WIS
Plug 'vim-scripts/restore_view.vim'    " restores cursor position and folds
Plug 'michaeljsmith/vim-indent-object' " Treat indent levels as text objects (cii - change inside indent). Essential for Haskell and Python

" Tidal
" Plug 'davidgranstrom/scnvim', { 'do': {-> scnvim#install() } }
" Plug 'tidalcycles/vim-tidal'

" Colorschemes and Ornamentation
Plug 'sainnhe/sonokai'
Plug 'sainnhe/edge'
" Plug 'ghifarit53/tokyonight-vim'
Plug 'sainnhe/everforest'         " Good with adjustments to background and foreground colors
" Plug 'morhetz/gruvbox'            " Too low contrast, don't like yellow text
" Plug 'joshdick/onedark.vim'       " Basic, not bad. Could be higher contrast
Plug 'sainnhe/gruvbox-material'   " Too low contrast, don't like the yellow text
" Plug 'rebelot/kanagawa.nvim'      " Not bad, yellow text though

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
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif


" colorscheme tokyonight
" let g:tokyonight_style = 'storm' " moon, storm, night, day
" let g:everforest_background = 'hard' " sets contrast. hard, medium, soft
let g:airline_theme = 'sonokai'
colorscheme sonokai

let g:gruvbox_material_background = 'hard' " 'hard', 'medium', 'soft'
" colorscheme papercolor

" === Bindings ===
" create file under cursor if it does not exist
nnoremap <leader>gf :e <cfile><cr>

" Move through tabs/buffers with grace
nnoremap <C-l> <ESC>:tabn <CR>
nnoremap <C-h> <ESC>:tabp <CR>
nnoremap <C-j> <ESC>:bn! <CR>
nnoremap <C-k> <ESC>:bp! <CR>

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

source $HOME/.config/nvim/plugin-settings/airline.vim
source $HOME/.config/nvim/plugin-settings/coc.vim
source $HOME/.config/nvim/plugin-settings/fzf.vim
source $HOME/.config/nvim/plugin-settings/tmux-navigator.vim
source $HOME/.config/nvim/plugin-settings/vimwiki.vim
