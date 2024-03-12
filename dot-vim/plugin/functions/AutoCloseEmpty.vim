function! AutoCloseNonfileBufs() abort
  let l:current_buf = bufnr()
  echom "---> AutoCloseEmpty()"
  echom "---> buf: #" . l:current_buf
  echom "--> exitcmd: " . w:exitcmd

  if( getbufvar(l:current_buf, "&buftype") != "" || !buflisted(l:current_buf) )
    echom "--> exiting " . bufnr() . ": not active or not file"
    return
  endif

  " get number of listed buffers that have a file
  let l:bufwins = uniq(tlib#list#Flatten(map(
  \   filter(
  \     getbufinfo({'buflisted': 1, 'bufloaded': 1}),
  \     'getbufvar(v:val.bufnr, "&buftype") == ""'
  \   ),
  \   'v:val.windows'
  \  )))

  echom "--> l:bufwins: " . string(l:bufwins)
  let l:file_bufs = len(l:bufwins)

  echom "--> l:file_bufs count: " . l:file_bufs

  " there's only one file buffer left
  if( l:file_bufs <= 1 )
    echom "--> closing all other buffers"
    silent tabonly

    let l:close_list = filter( getbufinfo(), 'getbufvar(v:val.bufnr, "&buftype") != ""' )
    for b in l:close_list
      echom "--> closing buffer: " . b
      " execute b.bufnr . "bdelete"
    endfor

    if ( exists('w:exitcmd') && w:exitcmd != "" )
      if match(w:exitcmd, "!")
        :q!
      else
        :q
      endif
    endif
  endif

  echom "---> / AutoCloseEmpty()"
endfunction

