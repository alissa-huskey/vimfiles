" echom "Loading colors/" .. expand("<sfile>:t") .. "..."

" general color related settings {{{
"
if exists('g:highlight_long_lines') && g:highlight_long_lines == 1
  let w:matchLongLines = matchadd('OverLength', '\%>80v.\+', -1)
endif

if exists('g:show_color_col') && g:show_color_col == 1
  set colorcolumn=80
endif

" brittspace
match ExtraWhitespace /\s\+$/

"
" }}}

function! s:call_background_function(type = "")
  " echom "s:call_background_function()"

  if a:type == ""
    let l:function_name = printf("s:custom_%s_background_colors", &background)
  else
    let l:function_name = printf("s:custom_%s_%s_background_colors", &background, a:type)
  endif
  " echom "s:call_background_function(): l:function_name = " .. l:function_name

  if exists("l:function_name")
    let Func = function(l:function_name)
    call Func()
  else
    " echom printf("s:call_background_function(): function doees not exist '%s'", l:function_name)
  endif
endfunction

" custom highlight colors
function! s:custom_colors()
  " echom "s:customize_colors()"

  highlight link QuickFixLine PmenuSel
  highlight link qferror      ErrorMsg

  highlight link QuickFixLine PmenuSel
  highlight link qferror      ErrorMsg

  highlight! link                   WarningMsg            Normal

  highlight  clear                  WildMenu
  highlight  link                   WildMenu              Normal

  highlight! link                     FoldColumn             Folded

  highlight  clear                  VertSplit
  highlight! link                   Normal                VertSplit

  " remove italics
  highlight  StatusLineNC                                   gui=NONE
  highlight  Folded                                         gui=NONE
  highlight  Tabline                                        gui=NONE
  highlight  TablineSel                                     gui=NONE
  highlight  Comment                                        gui=NONE

  highlight! link                   WildMenu              Normal
  highlight! link                   RedrawDebugRecompose  SpellBad
  highlight! link                   NvimInternalError     ErrorMsg

  highlight  NonText                                      ctermbg=NONE
  highlight  NonText                                        guibg=NONE

  call s:call_background_function()
endfunction

" custom highlight colors for dark backgrounds
function! s:custom_dark_background_colors()
  " echom "s:call_dark_background_function()"

  " long lines
  highlight OverLength ctermfg=204 ctermbg=black

  " general
  highlight  Normal                 ctermfg=252           ctermbg=NONE
  highlight  LineNr                                         guibg=Black
  highlight  LineNr                                       ctermbg=black
  highlight  SignColumn                                     guibg=Black
  highlight  SignColumn                                   ctermbg=black
  highlight  Normal                   guifg=#e8e8d3         guibg=NONE
  highlight  Todo                     guifg=#e8e8d3         guibg=NONE

  " autocomplete menu
  highlight  Pmenu                  ctermfg=black         ctermbg=gray
  highlight  Pmenu                    guifg=Black           guibg=Gray
  highlight  PmenuSel               ctermfg=black         ctermbg=103
  highlight  PmenuSel                 guifg=Black           guibg=#8787ae
  highlight  PmenuSbar              ctermfg=white         ctermbg=DarkGray
  highlight  PmenuSbar                guifg=White           guibg=DarkGray
  highlight  PmenuThumb             ctermfg=white         ctermbg=DarkGray
  highlight  PmenuThumb               guifg=White           guibg=DarkGray

  highlight  ColorColumn                                  ctermbg=black
  highlight  ColorColumn                                    guibg=Black

  " folds
  " highlight FoldColumn                guifg=#b0d0e0          guibg=#2C2E3E
  " highlight Folded                    guifg=#9fd4ff          guibg=#2C2E3E
  highlight Folded ctermfg=252 ctermbg=236 guifg=#c6c8d1 guibg=#272c42

  highlight  CursorLine                                    ctermbg=233      cterm=NONE
  highlight  CursorLine                                      guibg=#111111  gui=NONE

  highlight  VertSplit              ctermfg=243
  highlight  VertSplit              guifg=#767575

  " highlight  Normal                   guifg=#d7d7d6         guibg=#111111
  highlight  Search                 ctermfg=229           ctermbg=black
  highlight  Search                   guifg=#fefdd7         guibg=#1e1d40

  highlight  StatusLine             ctermfg=255           ctermbg=234     cterm=NONE
  highlight  StatusLine               guifg=#eeeeed         guibg=#1b1b1b   gui=NONE
  highlight  StatusLineNC           ctermfg=242           ctermbg=234     cterm=NONE
  highlight  StatusLineNC             guifg=#6c6c6b         guibg=#1b1b1b   gui=NONE
  highlight  User1                  ctermfg=242           ctermbg=234     cterm=NONE

  highlight  ErrorMsg               ctermfg=160           ctermbg=NONE
  highlight  ErrorMsg                 guifg=#d61d00         guibg=NONE
  highlight  WarningMsg               guifg=#ffd7d7
  highlight  WildMenu                 guifg=#ffafaf

  highlight  SpellBad                                     ctermbg=52
  highlight  SpellBad                                       guibg=#5e0700
  highlight  SpellCap                                     ctermbg=24
  highlight  SpellCap                                       guibg=#005f87
  highlight  SpellLocal                                   ctermbg=89
  highlight  SpellLocal                                     guibg=#86165e
  highlight  SpellRare                                    ctermbg=131
  highlight  SpellRare                                      guibg=#af5f5f

  highlight  RedrawDebugClear       ctermfg=233           ctermbg=230
  highlight  RedrawDebugClear         guifg=#111111         guibg=#fefdd7
  highlight  RedrawDebugComposed                          ctermbg=23
  highlight  RedrawDebugComposed                            guibg=#005f5e
  " highlight  RedrawDebugCompose                           ctermbg=23
  " highlight  RedrawDebugCompose                             guibg=#005f5e
  highlight GitGutterAddDefault     ctermfg=40            ctermbg=black
  highlight GitGutterAddDefault       guifg=#00d700         guibg=Black
  highlight GitGutterDeleteDefault  ctermfg=88            ctermbg=black
  highlight GitGutterDeleteDefault    guifg=#860e00         guibg=Black
  highlight GitGutterChange         ctermfg=229           ctermbg=black
  highlight GitGutterChange         guifg=#fefcaf           guibg=Black
endfunction

" custom highlight colors for light backgrounds
function! s:custom_light_background_colors()
  " echom "s:call_light_background_function()"
  " placeholder
endfunction

autocmd! ColorScheme * call s:custom_colors()
