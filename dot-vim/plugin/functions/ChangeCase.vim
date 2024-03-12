" Function: ChangeCase(mode, case) {{{2
" change the case of selected text, or all text on current line in normal mode
"
" Args:
"   - mode: a single letter string
"           - [n]ormal
"           - [v]isual
"
"   - case: a single letter
"           - [t]itle case
"           - [u]pper case
"           - [l]ower case
"
" Example:
"   call ChangeCase("n", "t")

function! ChangeCase(mode, case) abort range
  " echom printf("ChangeCase(%s, %s)", a:mode, a:case)

  let l:patterns = {
        \ "l": '(.)/\l\1/',
        \ "u": '(.)/\u\1/',
        \ "t": '<(.)(\w*)/\u\1\L\2/'
        \ }

  if ! has_key(l:patterns, a:case)
    echoe printf("[ChangeCase()] Unsupported case argument: %s (Allowed: %s)", a:case, keys(l:patterns))
    return
  endif

  let l:range = a:mode == "v" ? "'<,'>" : ""

  let l:command = printf('%ss/\v%s', l:range, l:patterns[a:case])

  " echom printf("command: %s", l:command)

  execute l:command
  nohlsearch

endfunction
command! -range -nargs=* ChangeCase call ChangeCase(<f-args>)
