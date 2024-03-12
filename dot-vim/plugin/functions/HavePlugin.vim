function! HavePlugin(plugin_name) abort
  for name in [ a:plugin_name, 'vim-' .. a:plugin_name, a:plugin_name .. '.vim', a:plugin_name .. '.nvim' ]
    let l:plugin_path = expand(g:plugins_dir) .. '/' .. name

    if isdirectory(l:plugin_path)
      return 1
    endif
  endfor

  return 0
endfunction
