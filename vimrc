set nocompatible

call plug#begin('~/.local/share/nvim/plugged')

" The Pope's Holy Plugins
Plug 'tpope/vim-commentary'            " use gcc to comment lines
Plug 'tpope/vim-fugitive'              " enhances netrw
Plug 'tpope/vim-repeat'                " more advanced dot repetition
Plug 'tpope/vim-sleuth'                " infers tab/space expansion from file
Plug 'tpope/vim-surround'              " wrap stuff with ([{ etc
Plug 'tpope/vim-vinegar'               " enhances netrw

" Navigation/File Management
Plug 'junegunn/fzf'                    " fuzzy file finder
Plug 'junegunn/fzf.vim'                " fuzzy file finder

" IDE ish
" Plug 'w0rp/ale'                        " Async Lint Engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vimwiki/vimwiki'
Plug 'sheerun/vim-polyglot'

" QoL
Plug 'airblade/vim-gitgutter'          " Show git diffs in file
Plug 'benmills/vimux'                  " Vim + Tmux
Plug 'christoomey/vim-tmux-navigator'  " Navigate vim/tmux panes
Plug 'junegunn/vim-easy-align'         " align stuff
Plug 'vim-airline/vim-airline'         " Betterer statusline
Plug 'vim-airline/vim-airline-themes'  " WISL
Plug 'vim-scripts/restore_view.vim'    " restores cursor position and folds

" Elm
Plug 'elmcast/elm-vim'

" Tidal
Plug 'davidgranstrom/scnvim', { 'do': {-> scnvim#install() } }
Plug 'tidalcycles/vim-tidal'

" Candy
Plug 'ghifarit53/tokyonight-vim'

call plug#end()                        " required

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
set showbreak=+++
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

" try to go to line under cursor
noremap <leader>gf :e <cfile><cr>

" Colors
set termguicolors
colorscheme tokyonight
let g:airline_theme = "tokyonight"
let g:tokyonight_style = 'storm'
let g:tokyonight_enable_italic = 1
set bg=dark

" fzf through Git Files
nnoremap <C-p> :GFiles<CR>
nnoremap <C-y> :Files<CR>
nnoremap <C-g> :Rg<CR>
nnoremap <C-b> :Buffers<CR>
imap <c-x><c-f> <plug>(fzf-complete-path)
autocmd! FileType fzf
autocmd FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
"   Use :Fzfc to view changed git files
command! Fzfc call fzf#run(fzf#wrap( {'source': 'git ls-files --exclude-standard --others --modified'}))
function! HandleFZF(file)
    echo a:file
endfunction
command! -nargs=1 HandleFZF :call HandleFZF(<f-args>)

" Move through tabs/buffers with grace
nnoremap <C-l> <ESC>:tabn <CR>
nnoremap <C-h> <ESC>:tabp <CR>
nnoremap <C-j> <ESC>:bn! <CR>
nnoremap <C-k> <ESC>:bp! <CR>

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
nnoremap <silent> <A-l> :TmuxNavigateRight<cr>
nnoremap <silent> <A-p> :TmuxNavigatePrevious<cr>

" Mark markdown as valid filetype
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Source coc.nvim settings
source $HOME/.vim/cocrc.vim

let g:vimwiki_list = [
    \ {'path': '~/zk', 'syntax': 'markdown', 'ext': 'md'},
    \ {'path': '~/infinite-jest/', 'syntax': 'markdown', 'ext': '.md'}, 
    \ {'path': '~/dox/sync-notes/', 'syntax': 'markdown', 'ext': 'md'}]
" By default vimwiki will intereprate all .md files as vimwiki
let g:vimwiki_global_ext = 0
" let g:vimwiki_auto_header = 1 " H1 with the file name on new file

au BufNewFile ~/zk/*.md 0r !~/zk/template.sh '%'
au BufNewFile ~/zk/*.md ks|:normal ggzf4j|'s
" from the helpfiles 'skeleton template'
autocmd BufWritePre,FileWritePre *.md   ks|call LastMod()|'s
fun LastMod()
  if line("$") > 10
    let l = 10
  else
    let l = line("$")
  endif
  exe "1," . l . "g/updated: /s/updated: .*/updated: " .
  \ strftime("%Y-%m-%d")
endfun

" Don't forget about the ftplugins

