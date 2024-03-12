" syntastic {{{
"
" NOTES:
" ":Errors -- display error window

"set statusline=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list   = 1
let g:syntastic_check_on_open              = 1
let g:syntastic_check_on_wq                = 0
let g:syntastic_auto_loc_list              = 1 " Close the location-list when errors are gone

if v:progname =~ "vimdiff"
  let g:syntastic_check_on_open = 0
  let b:syntastic_skip_checks = 1
  let g:syntastic_check_on_wq = 0
endif

highlight SyntasticErrorSign cterm=bold ctermfg=214 ctermbg=160
highlight SyntasticError term=bold ctermfg=220 ctermbg=166

"highlight clear SyntasticError
"highlight link SyntasticError SpellBad
"highlight link SyntasticWarning SpellCap

"highlight link SyntasticErrorLine PmenuSel
"highlight link SyntasticWarningLine PmenuSel

let g:syntastic_enable_signs             = 1
let g:syntastic_error_symbol             = '✗✗'
let g:syntastic_style_error_symbol       = '✗'
let g:syntastic_style_warning_symbol     = '⚠'
let g:syntastic_warning_symbol           = '⚠⚠'
" let g:syntastic_auto_jump                = 1
" let g:syntastic_check_on_open            = 0
" let g:syntastic_loc_list_height          = 5
" let g:syntastic_sh_shellcheck_args       = '--exclude=SC2001'
" let g:syntastic_sh_checkers              = ['shellcheck', 'sh']


" set wildignore+=build/**
" set wildignore+=dist/**

" }}} / syntastic

