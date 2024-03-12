" echom "Loading colors/" .. expand("<sfile>:t") .. "..."

function! s:custom_vimdiff_colors()
  highlight clear diffRemoved
  highlight link diffRemoved DiffDelete

  highlight clear diffAdded
  highlight link diffAdded DiffAdd


  s:call_background_function("diff")
endfunction

function! s:custom_vimdiff_colors_dark()
  " change the color scheme to not be so glaring
  highlight  DiffAdd      ctermfg=40      ctermbg=NONE      cterm=bold
  highlight  DiffAdd      guifg=#00d700     guibg=NONE        gui=bold

  highlight  DiffDelete   ctermfg=88      ctermbg=NONE      cterm=bold
  highlight  DiffDelete   guifg=#860e00     guibg=NONE        gui=bold

  highlight  DiffChange   ctermfg=black   ctermbg=159       cterm=bold
  highlight  DiffChange   guifg=Black       guibg=#affdff     gui=bold

  highlight  DiffText     ctermfg=99      ctermbg=159       cterm=bold
  highlight  DiffText     guifg=#875ffe     guibg=#affdff     gui=bold

  highlight  ExtraWhitespace               ctermbg=52
  highlight  ExtraWhitespace               guibg=#5e0700
endfunction

function! s:custom_vimdiff_colors_light()
  " placeholder
endfunction

autocmd ColorScheme * call s:custom_vimdiff_colors()
