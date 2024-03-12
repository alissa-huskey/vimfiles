" if exists("g:loaded_easy_align")

xnoremap ga <Plug>(EasyAlign)
nnoremap ga <Plug>(EasyAlign)

if !exists('g:easy_align_delimiters')
  let g:easy_align_delimiters = {}
endif

let g:easy_align_delimiters['w'] = {}
let g:easy_align_delimiters['w'] = {
      \ 'pattern': ' [ ]\+',
      \ 'left_margin': 4 }

" reset search highlighting
" as assigning new delims seems to leave it from pattern
noh
