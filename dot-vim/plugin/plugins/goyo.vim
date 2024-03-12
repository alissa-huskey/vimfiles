let g:goyo_width = '85%'

function! s:goyo_enter()
  let b:exitcmd = ""
  autocmd QuitPre <buffer> let b:exitcmd = histget("cmd", -1)
endfunction

function! s:goyo_leave()
  if b:exitcmd != "" && len(getbufinfo({ 'buflisted': 1 })) == 1
    exec b:exitcmd
  endif
endfunction

" autocmd! User GoyoEnter call <SID>goyo_enter()
" autocmd! User GoyoLeave call <SID>goyo_leave()
