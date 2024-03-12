function! HighlightGroup() abort
  echom synIDattr(synID(line('.'),col('.'),1),'name')
endfunction
