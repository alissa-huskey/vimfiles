let g:jqplay = {
    \ 'opts': '--tab',
    \ 'autocmds': ['TextChanged', 'CursorHoldI', 'InsertLeave']
    \ }


function! s:Play() abort
  if ! exists("g:loaded_jqplay")
    echoe "Jqplay plugin not found: bfrg/vim-jqplay"
    return 1
  endif

  if len( jqplay#ctx() ) == 0
  " open Jqplay

    if &ft != "json"
      echoe "Can only run Jqplay on json files. (ft: " .. &ft .. ")"
      return 1
    endif

    vert Jqplay
    wincmd j
    startinsert

  else
  " close Jqplay

    try
      call jqplay#close(1)
    catch /\<E516\>/                " E516: No buffers were deleted
    catch /\<E89\>/                 " E89: No write since last change
      let l:search_str = 'v:val.loaded == 1 && ( v:val.name =~ "^jq-output:" || v:val.name =~ "^jq-filter:" ) '
      let l:jqplay_bufs = map( filter( getbufinfo(), l:search_str ), 'v:val.bufnr' )
      for l:buf in l:jqplay_bufs
        exec l:buf .. "bdelete!"
      endfor

      call jqplay#close(0)
    endtry

  endif
endfunction
command! Play call s:Play()

function! s:JqplayOnQ() abort

  if ! exists("g:loaded_jqplay")
    return
  endif

  l:realbufs = ilter(getbufinfo(),
        \ 'v:val.listed == 1 && v:val.name !~ "^jq-output" && v:val.name !~ "^jq-filter"' )

  if len( l:realbufs ) <= 1
  endif

endfunction


" autocmd QuitPre <buffer> silent call s:JqplayOnQ
