setlocal noexpandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

" Auto format
augroup GolangFmt
  autocmd!
  autocmd BufWritePre <buffer> Fmt
augroup END

