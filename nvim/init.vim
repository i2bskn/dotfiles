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
  Plug 'jiangmiao/auto-pairs'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'mattn/vim-goimports'
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

" Display line number
set number

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

" vim-indent-guides {{{
" let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
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
