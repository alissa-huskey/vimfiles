" Set snippets and file locations as quickfix location list
" Return a list of the current snippet names and descriptions, tab delimited
function! GetSnippets()
  call UltiSnips#SnippetsInCurrentScope(1)
  let l:qflist = map(keys(g:current_ulti_dict_info), 'SnippetDictForQuickfix(v:val)')
  let g:qfmap = {}

  let l:i = 1
  while l:i < len(l:qflist)
    let l:info = l:qflist[l:i - 1]
    let g:qfmap[l:info.text] = l:i
    let l:i = l:i + 1
  endwhile

  call setqflist(l:qflist)

  return map(keys(g:current_ulti_dict_info), 'printf("%s\t%s", v:val, g:current_ulti_dict_info[v:val].description)')
endfunction

" Return dictionary for quickfix location list including filename, line
" number, and snippet name
function! SnippetDictForQuickfix(snippet)
  let l:info = g:current_ulti_dict_info[a:snippet]
  let l:loc = split(l:info.location, ':')
  return #{filename: l:loc[0], lnum: l:loc[1], text: a:snippet}
endfunction

" doesn't actually work, sadly
function! ExpandSnippet(line)
  let l:snippet = split(a:line, "\t")[0]
  let l:current = getline(".")
  let l:text = l:current . l:snippet
  let l:pos = getpos('.')
  call setline(".", l:text)
  call setpos('.', [l:pos[0], l:pos[1], l:pos[2] + 1, l:pos[3]])
  call UltiSnips#ExpandSnippet()
endfunction

" Edit the file for a given snippet
" NOTE: assumes that GetSnippets() has been called to define g:qfmap
function! EditFileForSnippet(line)
  let l:snippet = split(a:line, "\t")[0]
  echom printf("EditFileForSnippet()> snippet: %s", l:snippet)
  execute( printf('split | cc %s', g:qfmap[l:snippet]) )
endfunction

" Command to edit the file for a given snippet
command! -nargs=1 EditFileForSnippet call EditFileForSnippet("<args>")

" Command to list snippets in an FZF window
" that will edit a given snippet file
command! Snippets call fzf#run(fzf#wrap({
      \ 'source': GetSnippets(),
      \ 'options': '--prompt "Vim>" --delimiter "\t" --preview "echo {2}" --with-nth=1',
      \ 'sink': 'EditFileForSnippet',
      \ }))

function! CleanPath(path)
  let l:path = a:path
  let l:substitutions = {
        \ 'Dropbox/digital/system/dotfiles/config/nvim': '.vim',
        \ 'Dropbox/digital/system/dotfiles/': '.',
        \ $VIMRUNTIME: '$VIMRUNTIME',
        \ }

  for [a, b] in items(l:substitutions)
    let l:path = substitute(l:path, a, b, "")
  endfor

  return l:path
endfunction

function! GetScriptnames()
  let l:scriptnames = split(substitute(execute('scriptnames'), ' *\d*: ', '', 'g'), "\n")
  return map(l:scriptnames, 'printf("%s %s", CleanPath(v:val), expand(v:val))')
endfunction

command! Scriptnames call fzf#run(fzf#wrap({
        \ 'source': GetScriptnames(),
        \ 'options': '--prompt "Vim>" --preview "bat --language vim --color always {2} --file-name {1}" --with-nth=1',
        \ 'sink': 'pedit {2}',
    \ }))
