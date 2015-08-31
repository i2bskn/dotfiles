" Window size
set columns=160
set lines=54

" Font
set guifont=RictyDiminished-Regular:h13.5

" Not use GUI tab
set guioptions-=e

" Hide toolbar
set guioptions-=T

" Hide scrollbar
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b

" Edit .gvimrc
nnoremap <silent> ,g :<C-u>edit $MYGVIMRC<CR>
nnoremap <silent> ,gr :<C-u>source $MYGVIMRC<CR>

" Colorscheme for GVim
syntax enable
set t_Co=256
set background=light
colorscheme solarized
