function! NoninvasiveCompletionCR() abort
  return (pumvisible() ? "\<C-y>" : "\<CR>")
endfunction
