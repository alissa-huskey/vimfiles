" # Makefiles
"

augroup indent_cpp
  autocmd!

  autocmd FileType make setlocal nosmarttab nosmartindent noautoindent noexpandtab
  autocmd FileTYpe make setlocal tabstop=4 shiftwidth=4 softtabstop=0
  autocmd Filetype make setlocal list listchars=tab:»\ ,trail:·

augroup end
