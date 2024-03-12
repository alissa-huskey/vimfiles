function! Ls(dir) abort
  let l:files_str = globpath(expand(a:dir), '*')
  return split(l:files_str, "\n")
endfunction
