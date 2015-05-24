" vim:foldmethod=marker foldcolumn=2
" vim:tabstop=2 softtabstop=2 shiftwidth=2

" Charset / Line feed {{{
set encoding=utf-8
scriptencoding utf-8
set fileformats=unix,dos,mac
" }}}

filetype off
filetype plugin indent off

" Neobundle {{{
" Install neobundle if neobundle not installed.
if ! isdirectory(expand('~/.vim/bundle'))
  echon 'Installing neobundle.vim...'
  silent call mkdir(expand('~/.vim/bundle'), 'p')
  silent call system('git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim')
  echo 'done.'
  if v:shell_error
    echoerr 'neobundle.vim installation has failed!'
    finish
  endif
endif

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved"
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'Shougo/vimproc', {
  \   'build' : {
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \   },
  \ }

if has('lua')
  NeoBundleLazy 'Shougo/neocomplete', {
    \   'depends' : 'Shougo/vimproc',
    \ }
endif

NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'scrooloose/nerdtree'

if executable('ag')
  NeoBundle 'rking/ag.vim'
endif

NeoBundle 'tyru/caw.vim'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'i2bskn/reversal.vim'
NeoBundle 'ntpeters/vim-better-whitespace'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'

if executable('go')
  NeoBundle 'vim-jp/vim-go-extra'
endif

NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'slim-template/vim-slim'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
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
" Auto indentation
set autoindent

" Backspace behavior
set backspace=indent,eol,start
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

" Folding
set foldmethod=marker
set foldcolumn=2

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

" Folding open/close
nnoremap ,fo zo
nnoremap ,foo zO
nnoremap ,fc zc

" Exit insert mode
inoremap <silent> jj <ESC>

" Cancel highlights of search result
nnoremap <silent> <ESC><ESC> :<C-u>nohlsearch<CR>

" Replace shortcut
nnoremap gs :<C-u>%s///g<Left><Left><Left>

" Prev tag
nnoremap ,t <C-t>

" Edit .vimrc
nnoremap <silent> ,v :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> ,r :<C-u>source $MYVIMRC<CR>
" }}}

" Misc {{{
" matchit {{{
" %: Jump to brace corresponding
if !exists('loaded_matchit')
  runtime macros/matchit.vim
endif " }}}

" Not comment on the new line {{{
augroup NotCommentNewLine
  autocmd!
  autocmd FileType * setlocal formatoptions-=ro
augroup END " }}}

" To executable {{{
if executable('chmod')
  function! s:add_permission() " {{{
    let file = expand('%:p')
    if getline(1) =~# '^#!' && !executable(file)
      silent! call vimproc#system('chmod 755 ' . shellescape(file))
    endif
  endfunction " }}}

  augroup AddPermission
    autocmd!
    autocmd BufWritePost * call <SID>add_permission()
  augroup END
endif " }}}
" }}}

" neocomplete.vim {{{
if neobundle#tap('neocomplete')
  call neobundle#config({
    \   'autoload': {
    \     'insert': 1
    \   }
    \ })

  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

  " Define dictionary.
  let g:neocomplete#sources#dictionary#dictionaries = {
    \   'default' : ''
    \ }

  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings.
  inoremap <expr><C-g> neocomplete#undo_completion()
  inoremap <expr><C-l> neocomplete#complete_common_string()

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
  endfunction

  " <TAB>: completion.
  inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y> neocomplete#close_popup()
  inoremap <expr><C-e> neocomplete#cancel_popup()

  augroup MyOmniCompletion
    " Enable omni completion.
    autocmd!
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  augroup END

  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif

  let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
  let g:neocomplete#sources#omni#input_patterns.go = '[^.[:digit:] *\t]\.\w*'
  let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

  call neobundle#untap()
endif
" }}}

" ctrlp.vim {{{
if neobundle#tap('ctrlp.vim')
  let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:20'
  let g:ctrlp_switch_buffer = 'Et'
  let g:ctrlp_working_path_mode = 'ra'
  let g:ctrlp_use_caching = 1
  let g:ctrlp_clear_cache_on_exit = 0
  let g:ctrlp_open_new_file = 'r'
  let g:ctrlp_prompt_mappings = {
    \   'PrtBS()': ['<bs>'],
    \   'PrtCurLeft()': ['<left>'],
    \   'PrtCurRight()': ['<right>'],
    \   'PrtClearCache()': ['<c-l>'],
    \ }

  let g:ctrlp_mruf_max = 300

  " Buffer
  nnoremap <silent> <C-n> :<C-u>CtrlPBuffer<CR>
  " MRU
  nnoremap <silent> <C-m> :<C-u>CtrlPMRUFiles<CR>

  call neobundle#untap()
endif
" }}}

" nerdtree {{{
if neobundle#tap('nerdtree')
  let g:NERDTreeShowHidden = 1

  nnoremap <silent> <C-l> :<C-u>NERDTreeToggle<CR>

  call neobundle#untap()
endif
" }}}

" reversal.vim {{{
if neobundle#tap('reversal.vim')
  " Switch buffer to pair file.
  nmap ,w <Plug>(reversal:switch_buffer)

  call neobundle#untap()
endif
" }}}

" vim-indent-guides {{{
if neobundle#tap('vim-indent-guides')
  let g:indent_guides_auto_colors = 0
  let g:indent_guides_guide_size = 1
  let g:indent_guides_enable_on_vim_startup = 1

  augroup MyIndentGuides
    autocmd!
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=235
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=240
  augroup END

  call neobundle#untap()
endif
" }}}

" caw.vim {{{
if neobundle#tap('caw.vim')
  " ,c: commentout
  nmap ,c <Plug>(caw:i:toggle)
  vmap ,c <Plug>(caw:i:toggle)

  call neobundle#untap()
endif
" }}}

" vim-fugitive {{{
if neobundle#tap('vim-fugitive')
  nnoremap [git] <Nop>
  nmap ,g [git]

  nnoremap [git]d :<C-u>Gdiff<CR>
  nnoremap [git]b :<C-u>Gblame<CR>
endif
" }}}

" vim-markdown {{{
if neobundle#tap('vim-markdown')
  let g:vim_markdown_folding_disabled = 1

  call neobundle#untap()
endif
" }}}

" vim-go-extra {{{
if neobundle#tap('vim-go-extra')
  augroup Golang
    autocmd!
    autocmd BufWritePre *.go Fmt
    if executable('golint')
      autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow
    endif
  augroup END

  call neobundle#untap()
endif
" }}}

" lightline.vim {{{
if neobundle#tap('lightline.vim')
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

  let g:lightline = {
    \   'colorscheme': 'jellybeans',
    \   'active': {
    \     'left': [
    \       ['mode', 'paste'],
    \       ['git_branch_name', 'readonly', 'filename', 'modified']
    \     ]
    \   },
    \   'component_function': {
    \     'git_branch_name': 'GitBranchName'
    \   }
    \ }

  call neobundle#untap()
endif
" }}}

" Colorscheme {{{
syntax enable

if stridx($TERM, "256color") >= 0
  set t_Co=256
  colorscheme jellybeans
else
  set t_Co=16
  colorscheme default
endif
" }}}

" Local settings
if filereadable(expand('~/.vimrc.local'))
  execute 'source' expand('~/.vimrc.local')
endif

filetype on
