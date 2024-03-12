" echom "Loading colors/" .. expand("<sfile>:t") .. "..."
"
function! s:custom_vividchalk_colors()
  highlight   Search       ctermbg=234     ctermfg=229
endfunction

" no light varient

autocmd! ColorScheme vividchalk call s:custom_vividchalk_colors()
