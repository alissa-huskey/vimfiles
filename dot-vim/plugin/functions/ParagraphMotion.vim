" Function: ParagraphMotion(motion) {{{2
" Go to the start or end of a paragraph, but exclude the extra top/bottom of
" line added with { or } motion.
"
" Args:
"   - motion: either "{" or "}"
"
" Example:
"   call ParagraphMotion("}")

function! ParagraphMotion(motion) abort
  echom printf('ParagraphMotion(%s)', a:motion)

  " vim motion and the direction to travel for the desired cursor line
  let l:directions = {'{': 1, '}': -1} " (up=-1, down=1)

  " make sure the argument is valid
  if index(keys(directions), a:motion) < 0
    echoe printf("[ParagraphMotion(): invalid argument: '%s'", a:motion)
    return
  endif

  " column number of original cursor position
  let col = col("'>")

  " desired line number: up or down from the cursor following the vim motion
  let line = line(printf("'%s", a:motion)) + directions[a:motion]

  " move cursor to desired position
  call cursor(line, col)

endfunction


" normal mode mappings
nnoremap g{ :call ParagraphMotion('{')
nnoremap g} :call ParagraphMotion('}')

" visual mode mappings
vnoremap g{ :call ParagraphMotion('{')
vnoremap g} :call ParagraphMotion('}')

" select mode mappings
snoremap g{ :call ParagraphMotion('{')
snoremap g} :call ParagraphMotion('}')
