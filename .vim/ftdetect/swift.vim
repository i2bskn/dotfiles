function! s:setf(filetype)
  if &filetype !=# a:filetype
    let &filetype = a:filetype
  endif
endfunction

autocmd BufNewFile,BufRead *.swift call s:setf('swift')
