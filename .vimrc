" vim:foldmethod=marker foldcolumn=2
" vim:tabstop=2 softtabstop=2 shiftwidth=2

" Charset / Line feed {{{
set encoding=utf-8
scriptencoding utf-8
set fileformats=unix,dos,mac
" }}}

" Plugins {{{
" Install dein.vim if dein.vim not installed.
let s:plugin_dir = expand('~/.vim/dein')
let s:install_dir = s:plugin_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:plugin_dir)
  echon 'Installing dein.vim...'
  silent call mkdir(s:plugin_dir . '/repos/github.com/Shougo', 'p')
  silent call system('git clone https://github.com/Shougo/dein.vim ' . s:install_dir)
  echo 'done.'
  if v:shell_error
    echoerr 'dein.vim installation has failed!'
    finish
  endif
endif

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if &compatible
  set nocompatible " Be iMproved
endif

"set runtimepath+=s:install_dir
execute 'set runtimepath+=' . s:install_dir

" Required:
call dein#begin(s:plugin_dir)

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/vimproc', {
  \   'build' : 'make',
  \ })

call dein#add('ctrlpvim/ctrlp.vim')

call dein#add('i2bskn/ctrlp-altered', {
  \   'depends' : 'ctrlpvim/ctrlp.vim',
  \ })

if executable('ghq')
  call dein#add('mattn/ctrlp-ghq', {
    \   'depends' : 'ctrlpvim/ctrlp.vim',
    \ })
endif

call dein#add('scrooloose/nerdtree')
call dein#add('tyru/caw.vim')
call dein#add('jiangmiao/auto-pairs')
call dein#add('i2bskn/reversal.vim')
call dein#add('tpope/vim-endwise')
call dein#add('tpope/vim-surround')
call dein#add('itchyny/lightline.vim')
call dein#add('nathanaelkane/vim-indent-guides')

call dein#add('plasticboy/vim-markdown')
call dein#add('slim-template/vim-slim')
call dein#add('othree/yajs.vim')
call dein#add('othree/html5.vim')
call dein#add('mattn/vim-goimports')

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif
" }}}

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

" Backspace behavior
set backspace=indent,eol,start
" Not change the EOL
if v:version >= 800
  set nofixeol
endif
" Minimum margin
set scrolloff=5
" Complements file name
set wildmenu
" Complements list
set wildmode=list:longest
" Display another buffer without saving buffer
set hidden
" Reflect changes from another editor
set autoread
" Open the new window to right
set splitright
" Open the new window to under
set splitbelow

" Display line number
set number
" Hide tab and line break character
set nolist
" Display cursor position
set ruler
" Display command in the input
set showcmd
" Highlight corresponding brackets
set showmatch
" Highlight guideline to break
set colorcolumn=100
" Highlights cursor line
set cursorline
" Always show status line
set laststatus=2
" Don't overlap double byte character
set ambiwidth=double

" Folding
set foldmethod=marker
set foldcolumn=2

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

" Move current window
nnoremap wh <C-w>h
nnoremap wj <C-w>j
nnoremap wk <C-w>k
nnoremap wl <C-w>l

" Display current search result in the center
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Folding
nnoremap ,f za
nnoremap ,fr zR
nnoremap ,fm zM

" Quickfix
nnoremap ,cn :<C-u>cnext<CR>
nnoremap ,cp :<C-u>cprevious<CR>
nnoremap ,cc :<C-u>cclose<CR>

" Tags
nnoremap ,tn :<C-u>tnext<CR>
nnoremap ,tp :<C-u>tprevious<CR>
nnoremap <C-t> <Nop>
nnoremap ,tb <C-t>

" Pastetoggle
nnoremap <F2> :<C-u>set paste! paste?<CR>
set pastetoggle=<F2>

" Cancel highlights of search result
nnoremap <silent> <ESC><ESC> :<C-u>nohlsearch<CR>

" Grep shortcut
nnoremap <expr> <C-g> ':silent grep! ' . expand('<cword>')

" Replace shortcut
nnoremap gs :<C-u>%s///g<Left><Left><Left>

" Edit .vimrc
nnoremap <silent> ,v :<C-u>edit $MYVIMRC<CR>
" }}}

" Misc {{{
" matchit {{{
" %: Jump to brace corresponding
if !exists('loaded_matchit')
  runtime macros/matchit.vim
endif " }}}

" Individual FileType Settings {{{
augroup FileTypeSettings
  autocmd!
  autocmd FileType c setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType cpp setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType go setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType swift setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType markdown setlocal ts=4 sts=4 sw=4 expandtab
augroup END " }}}

" Grep Settings {{{
augroup GrepWithQuickFix
  autocmd!
  autocmd QuickFixCmdPost *grep* cwindow
augroup END

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
elseif executable('grep')
  set grepprg=grep\ -rnIH\ --exclude-dir=.git
else
  set grepprg=internal
endif " }}}
" }}}

" ctrlp.vim {{{
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_mruf_max = 300

let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:20'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_prompt_mappings = {
  \   'PrtCurLeft()': ['<left>'],
  \   'PrtCurRight()': ['<right>'],
  \   'PrtClearCache()': ['<c-l>'],
  \ }
let g:ctrlp_custom_ignore = {
  \   'dir':  '\v[\/]\.(git|svn)$|\v[\/](vendor|node_modules)$|\v\.(egg-info)$',
  \   'file': '\v\.(pyc)$',
  \ }

nnoremap [ctrlp] <Nop>
nnoremap m <Nop>
nmap m [ctrlp]

" Buffer
nnoremap <silent> [ctrlp]b :<C-u>CtrlPBuffer<CR>
" MRU
nnoremap <silent> [ctrlp]m :<C-u>CtrlPMRUFiles<CR>
" Tag
nnoremap <silent> [ctrlp]t :<C-u>CtrlPTag<CR>
" Dir
nnoremap <silent> [ctrlp]d :<C-u>CtrlPDir<CR>
" }}}

" ctrlp-altered {{{
let g:ctrlp_altered_commit_size = 5

" Altered
nnoremap <silent> [ctrlp]a :<C-u>CtrlPAltered<CR>
" }}}

" ctrlp-ghq {{{
" ghq
nnoremap <silent> [ctrlp]g :<C-u>CtrlPGhq<CR>
" }}}

" nerdtree {{{
let g:NERDTreeShowHidden = 1

nnoremap <silent> <C-l> :<C-u>NERDTreeToggle<CR>
" }}}

" reversal.vim {{{
let g:reversal_get_root_command = 'git rev-parse --show-toplevel'
let g:reversal_namespace_delimiter = {
  \   'vim': '-',
  \ }

" Switch buffer to pair file.
nmap ,w <Plug>(reversal:switch_buffer)
" }}}

" vim-indent-guides {{{
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1

augroup MyIndentGuides
  autocmd!
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=235
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=240
augroup END
" }}}

" caw.vim {{{
" ,c: commentout
nmap ,c <Plug>(caw:tildepos:toggle)
vmap ,c <Plug>(caw:tildepos:toggle)
" }}}

" vim-markdown {{{
let g:vim_markdown_folding_disabled = 1
" }}}

" lightline.vim {{{
let g:lightline = {
  \   'colorscheme': 'jellybeans',
  \   'active': {
  \     'left': [
  \       ['mode', 'paste'],
  \       ['git_branch_name', 'readonly', 'filename', 'modified'],
  \     ],
  \     'right': [
  \       ['lineinfo'],
  \       ['percent'],
  \       ['fileformat', 'fileencoding', 'filetype'],
  \     ],
  \   },
  \   'component_function': {
  \     'git_branch_name': 'GitBranchName',
  \   },
  \ }

function! GitBranchName() " {{{
  try
    if exists('*fugitive#head')
      let _ = fugitive#head()
      return strlen(_) ? _ : ''
    endif
  catch
  endtry
  return ''
endfunction " }}}
" }}}

" Colorscheme {{{
syntax enable

if stridx($TERM, "256color") >= 0
  set t_Co=256
else
  set t_Co=16
endif

try
  colorscheme jellybeans
catch
  colorscheme desert
endtry
" }}}

" Local settings
if filereadable(expand('~/.vimrc.local'))
  execute 'source' expand('~/.vimrc.local')
endif

filetype on
