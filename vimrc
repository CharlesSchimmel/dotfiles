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
" Plug 'w0rp/ale'                        " Async Link Engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vimwiki/vimwiki'
Plug 'sheerun/vim-polyglot'

" QoL
Plug 'airblade/vim-gitgutter'          " Show git changes (+-~) in file
Plug 'junegunn/vim-easy-align'         " Align stuff (like these comments)
Plug 'christoomey/vim-tmux-navigator'  " Navigate vim/tmux panes
Plug 'vim-airline/vim-airline'         " Betterer statusline
Plug 'vim-airline/vim-airline-themes'  " WISL
Plug 'vim-scripts/restore_view.vim'    " restores cursor position and folds
Plug 'junegunn/goyo.vim'               " Center the text area

" Candy
Plug 'drewtempelmeyer/palenight.vim'
Plug 'romainl/apprentice'
Plug 'sainnhe/sonokai'
Plug 'joshdick/onedark.vim'
Plug 'ghifarit53/tokyonight-vim'

call plug#end()                        " required

set autoindent
set backspace=indent,eol,start
set expandtab
set formatoptions=jcqorl
set hidden                                      " Prevents from exiting w/o saving. (q!)
set hlsearch
set incsearch
set laststatus=2                                " Always show statusbar
set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:× list
set nocompatible
set nrformats=                                  " Ignores non-decimal number formats (hint courtesy of practical vim, pg 21
set number
set ruler
set shiftround
set showbreak=+++
set showmatch
set smartcase ignorecase
set smartindent
set smarttab
set t_vb=
set textwidth=0
set undodir=$HOME/.vim/vimundo/
set undofile
set undolevels=1000
set visualbell
set wrap linebreak nolist                       " softwrap

filetype plugin indent on
syntax on
set bg=dark
highlight Search ctermbg=grey
set t_Co=256

" let g:sonokai_style = 'atlantis'
" let g:sonokai_enable_italic = 1
" let g:sonokai_disable_italic_comment = 1
set termguicolors

let g:tokyonight_style = 'storm' " available: night, storm
let g:tokyonight_enable_italic = 1

colorscheme tokyonight

" wild/globbing
set wildmode=list:longest,full
set wildmenu
set wildignorecase

" FZF
nnoremap <C-p> :GFiles<CR>
nnoremap <C-y> :Files<CR>
nnoremap <C-g> :Rg<CR>
nnoremap <C-b> :Buffers<CR>
inoremap <expr> <c-x><c-g> fzf#vim#complete#path('rg')
imap <c-x><c-f> <plug>(fzf-complete-path)
" imap <c-x><c-l> <plug>(fzf-complete-line)
autocmd! FileType fzf
autocmd FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
"   Use :Fzfc to view changed git files
command! Fzfc call fzf#run(fzf#wrap( {'source': 'git ls-files --exclude-standard --others --modified'}))
" inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
" Complete file path relative to current buffer
inoremap <expr> <c-x><c-f> fzf#vim#complete#path(
    \ "find . -path '*/\.*' -prune -o -print \| sed '1d;s:^..::'",
    \ fzf#wrap({'dir': expand('%:p:h')}))

" ALE
map <Leader>] :ALENext<cr>
map <Leader>[ :ALEPrevious<cr>
highlight ALEError cterm=underline
highlight ALEWarning cterm=underline

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" let g:airline_theme='onedark'
let g:airline_theme = "tokyonight"
let g:airline#extensions#coc#enabled = 1
let g:airline_mode_map = {
        \ '__':    '-',
        \ 'c':     'C',
        \ 'i':     'I',
        \ 'ic':    'I',
        \ 'ix':    'I',
        \ 'multi': 'M',
        \ 'n':     'N',
        \ 'ni':    '(I)',
        \ 'no':    'OP PENDING',
        \ 'R':     'R',
        \ 'Rv':    'VR',
        \ 's':     'S',
        \ 'S':     'SL',
        \ '':    'SB',
        \ 't':     'T',
        \ 'v':     'V',
        \ 'V':     'V',
        \ '':      'VB',
        \ }


" store swapfiles in one place instead of litterring them all over
set directory=$HOME/.vim/swapfiles//

" close netrw buffers
autocmd FileType netrw setl bufhidden=wipe

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>di <Plug>(coc-diagnostic-info)
nmap <silent> <leader>dn <Plug>(coc-diagnostic-next)
nmap <silent> <leader>dp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>cr <Plug>(coc-rename)
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
"
" " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" " Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

set updatetime=300
set signcolumn=yes
" === END coc.nvim === "

" === Custom Bindings === "
map <C-l> <ESC>:tabn <CR>
map <C-h> <ESC>:tabp <CR>
map <C-j> <ESC>:bn! <CR>
map <C-k> <ESC>:bp! <CR>
" map <C-p> <ESC>:b# <CR>

" Move between panes
let g:tmux_navigator_no_mappings = 1
nnoremap <A-h> :TmuxNavigateLeft<CR>
nnoremap <A-j> :TmuxNavigateDown<CR>
nnoremap <A-k> :TmuxNavigateUp<CR>
nnoremap <A-l> :TmuxNavigateRight<CR>
nnoremap <A-p> :TmuxNavigatePrevious<CR>

if &diff
    nmap <leader>gr :diffg REMOTE<cr>
    nmap <leader>gl :diffg LOCAL<cr>
endif
let g:coc_node_path="/home/schimmch/.nvm/versions/node/v10.16.3/bin/node"

" VimWiki
let g:vimwiki_auto_header = 1
" to replace spaces with underscores: 'links_space_char': '_'
let g:vimwiki_list = [{'path': '~/notes/', 'syntax': 'markdown', 'ext': '.md'}]
" By default VimWiki will interprate all .md files as VimWiki files. This disables that.
let g:vimwiki_global_ext = 0 
" Always append .md extension when creating new items or filling existing items
" let g:vimwiki_markdown_link_ext = 1
