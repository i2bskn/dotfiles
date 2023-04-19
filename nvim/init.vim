let data_dir = stdpath('data')
let vim_plug_path = data_dir . '/site/autoload/plug.vim'
if empty(glob(vim_plug_path))
  silent execute '!curl -fLo '.vim_plug_path.' --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin(data_dir.'/plugged')
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'preservim/nerdtree'
  Plug 'jiangmiao/auto-pairs'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-fugitive'
  Plug 'sheerun/vim-polyglot'
  Plug 'slim-template/vim-slim'
  Plug 'w0ng/vim-hybrid'
  Plug 'itchyny/lightline.vim'
  Plug 'itchyny/vim-gitbranch'
call plug#end()

" check the specified plugin is installed
function s:is_plugged(name)
  if exists('g:plugs') && has_key(g:plugs, a:name) && isdirectory(g:plugs[a:name].dir)
    return 1
  else
    return 0
  endif
endfunction

" Vim options {{{
" Do not create backup, swapfile, undofile
set nobackup
set noswapfile
set noundofile

" Incremental search
set incsearch
" Highlights search result
set hlsearch
" Case insensitive
set ignorecase
" Case sensitive if including uppercase
set smartcase
" Back to top when search to end
set wrapscan

" Tab spaces
set tabstop=2
" Operation tab spaces
set softtabstop=2
" Indent size
set shiftwidth=2
" Expand tab to spaces
set expandtab
" Indentation
set autoindent
set cindent
set cinoptions+=g0

" " Backspace behavior
" set backspace=indent,eol,start
" " Minimum margin
" set scrolloff=5
" " Complements file name
" set wildmenu
" " Complements list
" set wildmode=list:longest
" Display another buffer without saving buffer
set hidden
" " Reflect changes from another editor
" set autoread
" " Open the new window to right
" set splitright
" " Open the new window to under
" set splitbelow

" Display line number
set number

" " Hide tab and line break character
" set nolist
" " Display cursor position
" set ruler
" " Display command in the input
" set showcmd
" " Highlight corresponding brackets
" set showmatch
" " Highlight guideline to break
" set colorcolumn=100
" " Highlights cursor line
" set cursorline
" " Always show status line
" set laststatus=2
" " Don't overlap double byte character
" set ambiwidth=double

" " Folding
" set foldmethod=marker
" set foldcolumn=2

" Tags
set tags+=.git/tags;
" }}}

" Keymaps {{{
" Head of line/End of line
noremap <Space>h g^
noremap <Space>l g$

" Intuitive jk
nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k
vnoremap j gj
vnoremap gj j
vnoremap k gk
vnoremap gk k

" Display current search result in the center
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Folding
" nnoremap ,f za
" nnoremap ,fr zR
" nnoremap ,fm zM

" Quickfix
" nnoremap ,cn :<C-u>cnext<CR>
" nnoremap ,cp :<C-u>cprevious<CR>
" nnoremap ,cc :<C-u>cclose<CR>

" Tags
" nnoremap ,tn :<C-u>tnext<CR>
" nnoremap ,tp :<C-u>tprevious<CR>
" nnoremap <C-t> <Nop>
" nnoremap ,tb <C-t>

" Pastetoggle
" nnoremap <F2> :<C-u>set paste! paste?<CR>
" set pastetoggle=<F2>

" Cancel highlights of search result
nnoremap <silent> <ESC><ESC> :<C-u>nohlsearch<CR>

" Replace shortcut
nnoremap gs :<C-u>%s///g<Left><Left><Left>
" }}}

" fzf.vim {{{
let g:fzf_command_prefix = 'Fzf'

nnoremap [fzf] <Nop>
nnoremap m <Nop>
nmap m [fzf]

nnoremap [fzf]m :<C-u>FzfFiles<CR>
nnoremap [fzf]a :<C-u>FzfAg<CR>
nnoremap [fzf]b :<C-u>FzfBuffers<CR>
nnoremap [fzf]h :<C-u>FzfHistory<CR>
" }}}

" nerdtree {{{
let g:NERDTreeShowHidden = 1

nnoremap <silent> <C-l> :<C-u>NERDTreeToggle<CR>
" }}}

let g:lightline = {
  \   'colorscheme': 'wombat',
  \   'active': {
  \     'left': [
  \       ['mode', 'paste'],
  \       ['gitbranch', 'readonly', 'filename', 'modified'],
  \     ],
  \     'right': [
  \       ['lineinfo'],
  \       ['percent'],
  \       ['fileformat', 'fileencoding', 'filetype'],
  \     ],
  \   },
  \   'component_function': {
  \     'gitbranch': 'gitbranch#name',
  \   },
  \ }

if s:is_plugged("vim-hybrid")
  set background=dark
  colorscheme hybrid
else
  colorscheme desert
endif
