function! s:setf(filetype)
  if &filetype !=# a:filetype
    let &filetype = a:filetype
  endif
endfunction

" Interactive Ruby
autocmd BufNewFile,BufRead .irbrc,.pryrc call s:setf('ruby')

" Jbuilder
autocmd BufNewFile,BufRead *.jbuilder call s:setf('ruby')

" Capistrano
autocmd BufNewFile,BufRead *.cap,Capfile call s:setf('ruby')

" Rubygems
autocmd BufNewFile,BufRead .gemrc call s:setf('yaml')
