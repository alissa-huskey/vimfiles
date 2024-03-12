
function! Plugins() abort
  let l:list = []
  for l:plugin_path in Ls(g:pluginsrc_dir)
    let l:name = fnamemodify(l:plugin_path, ":t")
    let l:name = substitute(l:name, '^\(.*\).vim$', '\=submatch(1)', "")
    call add(l:list, l:name)
  endfor

  let l:list = sort(split(l:name, "\n"))
  for l:plugin in l:list
    echo l:plugin
  endfor
  return l:list
endfunction
command! Plugins call Plugins()
