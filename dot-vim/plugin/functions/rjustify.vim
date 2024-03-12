function! RJustify() abort
  let l:line = line('.')
  execute l:line .. 's/\v {2,}/_WS_/'

  normal! $
  let l:col = col('.')

  normal! k$
  let l:width = col('.')

  let l:diff = l:width - l:col + 4
  execute l:line .. 's/_ws_/'.. repeat(' ', l:diff) .. '/'

endfunction
