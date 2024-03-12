function! GoToCode() abort
  let l:fname = substitute(expand('%'), '_test', '', '.')
  echom printf("opening code file: %s", l:fname)
  exec "edit " .. l:fname
endfunction

function! GoToTest() abort
  let l:fname = substitute(expand('%'), '.go', '_test.go', '.')
  echom printf("opening test file: %s", l:fname)
  exec "edit " .. l:fname
endfunction
