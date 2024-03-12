function! TryWrapper(cmd)
    " echom printf("TryWrapper(%s)", a:cmd)

    try
      " echom printf("au DirChanged %s", a:cmd)
      execute printf("au DirChanged %s", a:cmd)
    catch /^Vim:E475:.* Channel doesn't exist/
    endtry

endfunction


function! FixDirChanged()
  " echom "FixDirChanged()"
  let lines = split(execute("au DirChanged"), "\n")

  let [cmds, block, bug] = [[], "", v:null]

  let idx = index(lines, "DirChanged")
  " echom "idx: ".idx

  if idx < 0
    return
  endif

  " set cmds to a  list of DirChanged commands not including
  " the rpcnotify command, and set bug to the rpcnotify command
  for line in lines[idx+1:]
    " done when a new block starts
    if line =~ "DirChanged"
      break
    endif

    " if (! line =~ "rpcnotify.*python_chdir") || line =~ "silent"
    if (! line =~ "rpcnotify.*python_chdir") || line =~ "TryWrapper"
      " echom printf("adding: %s", line)
      if index(cmds, line) < 0
        call add(cmds, line)
      endif
    else
      " echom printf("bug = %s", line)
      let bug = line
    endif

  endfor

  " echom printf("cmds: %s", cmds)

  " remove all DirChanged commands
  au! DirChanged

  " make the erroring command silent
  if !empty(bug)
    " E475: Invalid argument: Channel doesn't exist
    " execute printf("au DirChanged %s", substitute(bug, "call", "silent! call", ""))
    " echom printf("bug: %s", bug)
    " call TryWrapper(bug)
    let words = split(bug)
    let when = remove(words, 0)
    execute printf("au DirChanged %s call TryWrapper('%s')", when, join(words))
  endif

  " add other DirChanged commands back
  for cmd in cmds
    execute printf("au DirChanged %s", cmd)
  endfor

  return cmds
endfunction

au BufReadPost * call FixDirChanged()
