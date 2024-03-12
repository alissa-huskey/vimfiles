let g:syntastic_sh_shellcheck_args='--external-sources'
let g:syntastic_auto_loc_list = 1


" SC2034: VAR appears unused. Verify use (or export if used externally)
" SC2086: Double quote to prevent globbing and word splitting
" SC2154: VAR is referenced but not assigned
" SC1090: Can't follow non-constant source. Use a directive to specify location
let g:syntastic_quiet_messages = { 'regex': 'SC2034\|SC2068\|SC2086\|SC2154' }

if exists('g:syntastic_sh_include_dirs')
  let g:syntastic_sh_shellcheck_args .= ' --source-path=' .. g:syntastic_sh_include_dirs
endif

if exists('b:is_bash')
  set iskeyword+=:
endif

" let g:syntastic_sh_shellcheck_args = '-e SC2148'
"
" autocmd FileInclude sh let g:syntastic_sh_shellcheck_args =
"     \ get(g:, 'syntastic_sh_shellcheck_args', '') .
"     \ FindConfig('', '.sh', expand('<afile>:p:h', 1))
