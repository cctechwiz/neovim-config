" ~~~ VIM-PLUG ~~~
" ~~~~~~~~~~~~~~~~
" See: https://github.com/junegunn/vim-plug
call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Completions: https://github.com/Shougo/deoplete.nvim/wiki/Completion-Sources

Plug 'airblade/vim-gitgutter'

Plug 'sheerun/vim-polyglot'

Plug 'vimwiki/vimwiki'

Plug 'sainnhe/edge'

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
set wildmenu
set showcmd
set splitbelow
set splitright
set undodir=~/.config/nvim/undodir
set undofile
set clipboard+=unnamedplus


" ~~~ SEARCHING ~~~
" ~~~~~~~~~~~~~~~~~
set showmatch
set ignorecase
set smartcase
set incsearch
set hlsearch


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
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab


" ~~~ APPEARANCE / THEMES ~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~
set termguicolors
set background=dark
colorscheme edge


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
noremap <C-A-Left> :bp<CR>
noremap <C-A-Right> :bn<CR>
" Splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" ~~~ LEADER MAPPINGS ~~~
" ~~~~~~~~~~~~~~~~~~~~~~~
:let mapleader=","
:map <leader>, :nohl<CR>
:map <leader>s :mksession<CR>
:map <leader>n :call ToggleLineNumbering()<CR>


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


" ~~~ FILETYPE SPECIFIC ~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~
augroup markdown
  autocmd!
  autocmd BufNewFile,BufRead *.md,*.markdown setlocal filetype=markdown
  autocmd FileType markdown set spell spelllang=en_us
augroup END


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

" ~~~ Deoplete ~~~
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1
inoremap <silent><expr> <C-Space> deoplete#manual_complete()

" ~~~ Git Gutter ~~~
" Update gitgutter on save
autocmd BufWritePost * GitGutter

" ~~~ Vimwiki ~~~
let g:vimwiki_list = [
      \ {'path': '~/gtdwiki/', 'syntax': 'markdown', 'ext': '.md'},
      \ {'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'},
  \]
" Open selected link in a new vertical split with ,v
nmap <leader>v <Plug>VimwikiVSplitLink

" ~~~ Silver Searcher ~~~
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nnoremap \ :Ag<space>
endif

