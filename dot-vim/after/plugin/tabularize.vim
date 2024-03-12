" extra :Tabularize commands

if !exists(':Tabularize')
  finish
endif

" Make line wrapping possible by resetting the 'cpo' option, first saving it
let s:save_cpo = &cpo
set cpo&vim

" AddTabularPattern! asterisk /*/l1

" AddTabularPipeline! remove_leading_spaces /^ /
"                 \ map(a:lines, "substitute(v:val, '^ *', '', '')")

function! TabularizeWhitespace(cmd)

  if visualmode() == ""
		echohl WarningMsg | echo "Please select a range of lines" | echohl None
    return
  endif

  execute "'<,'>" .. 's/\v {2,}/_WS_/ge'
  silent! execute 'Tabularize /_WS_/' .. a:cmd
  execute "'<,'>" .. 's/_WS_/    /g'

endfunction

AddTabularPipeline! multiple_spaces / \{2,}/
\ map(a:lines, "substitute(v:val, ' \{2,}', '  ', 'g')")
\   | tabular#TabularizeStrings(a:lines, '  ', 'l0')

function! s:TableFormat()
    let l:pos = getpos('.')
    normal! {
    " Search instead of `normal! j` because of the table at beginning of file edge case.
    call search('|')
    normal! j
    " Remove everything that is not a pipe, colon or hyphen next to a colon othewise
    " well formated tables would grow because of addition of 2 spaces on the separator
    " line by Tabularize /|.
    let l:flags = (&gdefault ? '' : 'g')
    execute 's/\(:\@<!-:\@!\|[^|:-]\)//e' . l:flags
    execute 's/--/-/e' . l:flags
    Tabularize /|
    " Move colons for alignment to left or right side of the cell.
    execute 's/:\( \+\)|/\1:|/e' . l:flags
    execute 's/|\( \+\):/|:\1/e' . l:flags
    execute 's/ /-/' . l:flags
    call setpos('.', l:pos)
endfunction

" tables look like this
"
" | Tables        | Are           | Cool  |
" | ------------- |:-------------:| -----:|
" | col 3 is      | right-aligned | $1600 |
" | col 2 is      | centered      |   $12 |
" | zebra stripes | are neat      |    $1 |


    " s/ \(
    "       :                                 " literal :
    "       \@<!                              " like jq | not       preceding atom does not match just before what follows
    "        -:                               " literal -:
    "       \@!                               " - not before :      preceding atom does not matc at the current position
    "       \|                                " literal |
    "        [^|:-]                           " not | : -
    "     \)//e'


" Restore the saved value of 'cpo'
let &cpo = s:save_cpo
unlet s:save_cpo
