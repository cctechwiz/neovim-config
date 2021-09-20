" ~~~ VIM-PLUG ~~~
" ~~~~~~~~~~~~~~~~
if has("unix")
  " https://github.com/junegunn/vim-plug#unix-linux
  call plug#begin('~/.local/share/nvim/plugged')
endif
if has("win32")
  " https://github.com/junegunn/vim-plug#windows-powershell-1
  call plug#begin('~/AppData/Local/nvim/plugged')
endif

" https://github.com/fatih/vim-go/wiki/Tutorial
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'AndrewRadev/splitjoin.vim'

Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}

Plug 'airblade/vim-gitgutter'

if executable('tmux')
  Plug 'wellle/tmux-complete.vim'
  Plug 'christoomey/vim-tmux-navigator' " Requires changes in ~/.tmux.conf
  Plug 'tmux-plugins/vim-tmux-focus-events' " Fixes gutter refreshing in tmux
endif

Plug 'vimwiki/vimwiki'

Plug 'sainnhe/edge'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

call plug#end()


" ~~~ GENERAL ~~~
" ~~~~~~~~~~~~~~~
filetype plugin indent on
syntax enable
set title
set history=5000
set undolevels=5000
set number
set relativenumber
set signcolumn=yes
set hidden
set autoread
set autowrite
set wildmenu
set showcmd
set splitbelow
set splitright
set clipboard+=unnamedplus
set noshowmode
set scrolloff=8

if has("unix")
  set undodir=~/.config/nvim/undodir
endif
if has("win32")
  set undodir=~/AppData/Local/nvim/undodir
endif

set undofile


" ~~~ SEARCHING ~~~
" ~~~~~~~~~~~~~~~~~
set showmatch
set ignorecase
set smartcase
set incsearch
set hlsearch
set inccommand=nosplit


" ~~~ FORMATTING ~~~
" ~~~~~~~~~~~~~~~~~~
set backspace=indent,eol,start
set listchars=eol:⚬,tab:▸▸,trail:␣
set list
set ruler
set wrap linebreak
set colorcolumn=81
highlight colorcolumn ctermbg=darkgray
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab


" ~~~ GO SPECIFIC ~~~
" ~~~~~~~~~~~~~~~~~~~
augroup go
    au FileType go set noexpandtab
    autocmd FileType go nmap <leader>b  <Plug>(go-build)
    autocmd FileType go nmap <leader>r <Plug>(go-rename)
    autocmd FileType go nmap <leader>i <Plug>(go-info)
    autocmd FileType go nmap <leader>I <Plug>(go-implements)
    autocmd FileType go nmap <leader>d <Plug>(go-def-vertical)
    autocmd FileType go nmap <leader>D <Plug>(go-describe)
    autocmd FileType go nmap <leader>? <Plug>(go-doc)
    autocmd FileType go nmap <leader>?? <Plug>(go-doc-browser)
    autocmd FileType go nmap <leader>c <Plug>(go-referrers)
    autocmd FileType go nmap <leader>C <Plug>(go-callstack)
    autocmd FileType go nmap <leader>p <Plug>(go-channel-peers)
augroup END

let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_addtags_transform = "camelcase"

let g:go_highlight_types = 1


" ~~~ APPEARANCE / THEMES ~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~
set termguicolors
set background=dark
colorscheme edge
set laststatus=2
set showtabline=2
let g:lightline = {'colorscheme': 'edge'}
let g:lightline.tabline = {'left': [['buffers']], 'right': [['bufnum']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type = {'buffers': 'tabsel'}
hi! link Search PMenu
hi! link IncSearch PMenuSel


" ~~~ NAVIGATION MAPPINGS ~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Wrapped lines
noremap j gj
noremap k gk
noremap <Down> gj
noremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
" Buffers
nnoremap <A-h> :bp<CR>
nnoremap <A-l> :bn<CR>
" Splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Quickfix Menu
nnoremap <C-Right> :cnext<CR>
nnoremap <C-Left> :cprevious<CR>
nnoremap <C-Down> :cclose<CR>
nnoremap <C-Up> :copen<CR>


" ~~~ LEADER MAPPINGS ~~~
" ~~~~~~~~~~~~~~~~~~~~~~~
:let mapleader=","
:map <leader>, :nohl<CR>
:map <leader>s :mksession<CR>
:map <leader>n :call ToggleLineNumbering()<CR>


" ~~~ OMNI COMPLETION ~~~
" ~~~~~~~~~~~~~~~~~~~~~~~
inoremap <C-Space> <C-x><C-o>
:set completeopt=longest,menuone


" ~~~ OTHER MAPPINGS ~~~
" ~~~~~~~~~~~~~~~~~~~~~~
:map <F4> :call ToggleSpellChecking()<CR>
nmap <F3> i<C-R>=strftime('# %Y-%m-%d #')<CR><CR><Esc>
imap <F3> <C-R>=strftime('# %Y-%m-%d #')<CR><CR>


" ~~~ FUNCTIONS ~~~
" ~~~~~~~~~~~~~~~~~
function! ToggleLineNumbering()
  if(&relativenumber == 1)
    set norelativenumber
    set number
  else
    set relativenumber
  endif
endfunc

function! ToggleSpellChecking()
  if(&spell ==1)
    set nospell
  else
    set spell spelllang=en_us
  endif
endfunc


" ~~~ PLUG-INS / 3RD PARTY ~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" ~~~ NERD Tree ~~~
map <C-n> :NERDTreeToggle<CR>
:let g:NERDTreeWinSize=40
" Automatically open NERDTree if vim opened a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1
  \ && isdirectory(argv()[0])  && !exists("s:std_in")
  \ | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" Close vim if NERDTree is the only buffer with data on quit
autocmd bufenter * if (winnr("$") == 1
  \ && exists("b:NERDTree") && b:NERDTree.isTabTree())
  \ | q | endif

" ~~~ Git Gutter ~~~
" Update gitgutter on save
autocmd BufWritePost * GitGutter

" ~~~ Vimwiki ~~~
let g:vimwiki_list = [
      \ {'path': '/Volumes/GoogleDrive/My Drive/vimwiki', 'syntax': 'markdown', 'ext': '.md'},
  \]
" Only treat .md files in the wiki directory as vimwiki files
"let g:vimwiki_global_ext = 0

" ~~~ Ripgrep ~~~
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --glob\ '!.git'
  command -nargs=+ -complete=file -bar Rg silent! grep! <args>|cwindow|redraw!
  nnoremap \ :Rg<space>
endif

