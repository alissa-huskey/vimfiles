" status line {{{
"

" always show the status line
set laststatus=2

" show the cursor position at the bottom status bar
" note: overridden by statusline, here as default fallback
set ruler

let g:edit_status = 0

" WARNING: exercise extreme caution when editing this function!
"          errors will royally fuck all open vim sessions
"
"          to edit safely, change g:edit_status to 1 above
"          and reload vimrc (<Leader>s or source <vimrc>)
"          BEFORE making changes
"
"          test changes with:
"             echo Status(winnr())
"             call setwinvar(winnr(), '&statusline', '%!Status(winnr())')
"
"          to unfuck: :wqa and vim --clean <vimrc>
"
" for most files
" <flags><filename> (<buffernum>) | <position info> [<filetype>] <time>
" for nerdtree and folddigest, just the <buffer name>
" if syntastic errors exist, replace left side with error info
function! Status(winnr)
  let l:left_status   = "%q%h%r%w "                 " flags : <quickist><help><readonly><preview>
  let l:left_status  .= "%f (%n)"                   " <filename> (<buffer num)

  let l:right_status  = "%="                        " switch to right
  let l:right_status .= "%l:%c %L "                 " <line>:<col> <lines>
  let l:right_status .= "%y "                       " file type
  let l:right_status .= "<" . mode() . "> "         " editing mode
  let l:right_status .= "%{strftime('%I:%M%p')}"    " 12 hour time  <hour>:<min><AMPM>

  let l:bufnum = winbufnr(a:winnr)
  let l:type = getbufvar(l:bufnum, '&buftype')
  let l:name = bufname(l:bufnum)

  if name =~ "FOLDDIGEST"
    return name
  elseif name =~ "NERD_tree"
    return "NERDTree"
  endif

   if exists("*SyntasticStatuslineFlag")
    let flag = SyntasticStatuslineFlag()

    if !empty(flag)
      return "%#WarningMsg#" . flag . "%#StatusLine#" . l:right_status
    endif
   endif

  return l:left_status . l:right_status
endfunction

" refresh the statusline for each window
function! s:RefreshStatus()
  for nr in range(1, winnr('$'))
    call setwinvar(nr, '&statusline', '%!Status(' . nr . ')')
  endfor
endfunction

" refresh the statusline after:
" startup, switching windows, and buffer display
augroup status
  autocmd!
  if ! edit_status
    autocmd VimEnter,WinEnter,BufWinEnter * call <SID>RefreshStatus()
  endif
augroup END

"
" }}} / status line


