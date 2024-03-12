if (exists('g:loaded_gutentags'))

  if !exists('g:gutentags_project_root')
      let g:gutentags_project_root = []
  endif
  let g:gutentags_define_advanced_commands=1
  " let g:gutentags_trace=1
  let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']

  let g:gutentags_project_root += [ 'Makefile' ]
  let g:gutentags_ctags_tagfile = '.tags'
  " if executable('ripper-tags')
    " let g:gutentags_define_advanced_commands = 1
    " let g:gutentags_ctags_executable_ruby = 'ripper-tags --ignore-unsupported-options'
    " let g:gutentags_ctags_exclude = ['vendor/assets/', 'app/assets', 'log', 'tmp', '.git']
  " endif

endif
