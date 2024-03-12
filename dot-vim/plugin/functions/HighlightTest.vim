function! HighlightTest() abort
  let l:current_buf = bufnr()

  " find any open buffer named "Highlight Test"
  let l:old_hitest_buf =
  \   filter(
  \     getbufinfo({'buflisted': 1, 'bufloaded': 1}),
  \     'match(v:val["name"], "Highlight Test$") >= 0'
  \   )

  " delete the old "Highlight Test" buffer
  if ( len(l:old_hitest_buf) > 0 )
    execute l:old_hitest_buf[0].bufnr . "bdelete"
  endif

  " source the builtin script to run the highlight test
  source $VIMRUNTIME/syntax/hitest.vim
endfunction
