" HardPencil
" call pencil#init({'wrap': 'hard'})
" GitGutterDisable
" Goyo
"
set conceallevel=0

" Return a "s/search/replace/" command in the selected area to:
" Replace char_a surrounded by backtick ("`") with char_b
function! ReplaceEnclosedChar(enclosing_char, char_a, char_b) range abort
  let enclosing_char = "\`"
  " 
  " ┆

  let l:search = printf(
        \ '%s' . 
        \ '\([^%s%s]*\)' . 
        \ '[%s]' .
        \ '\([^%s%s]*\)' . 
        \ '%s',
        \ a:enclosing_char,
        \ a:enclosing_char, a:char_a,
        \ a:char_a,
        \ a:char_a, a:enclosing_char,
        \ a:enclosing_char
        \ )

  let l:replace = printf('%s\1%s\2%s', a:enclosing_char, a:char_b, a:enclosing_char)
  let l:command = printf("'<,'>s/%s/%s/e", l:search, l:replace)

  " echom "command: " . l:command
  "
  execute printf(l:command)

endfunction

function! Bold() abort range
  echom "Bold()"

  let l:command = "'<,'> " . 's/\v^(.*)$/**&**/'

  " echom printf("command: %s", l:command)

  execute l:command
  nohlsearch

endfunction

function! Header(level) abort range
  echom printf("Header(%s)", a:level)

  let l:cur_lineno = line(".")
  let l:next_lineno = l:cur_lineno + 1
  let l:header_text = getline(l:cur_lineno)
  let l:cur_level = 0
  let l:new_level = a:level

  " remove setex headers
  " '<next_lineno>g/\v^[-=]+$/d'
  let l:setex_text = getline(l:next_lineno)
  if l:setex_text =~ '^[-=]\+$'
    let l:cur_level = l:setex_text =~ '=' ? 1 : 2
    call deletebufline(bufname(), l:next_lineno)
    " echom printf("setex header level: %s", l:cur_level)
  endif

  " remove atx header
  " s/\v^#{1,6} //
  if l:header_text =~ '^#\{1,6}'
    let l:cur_level = matchend(l:header_text, '^#\{1,6}')
    let l:header_text = substitute(l:header_text, '^#\{1,6} ', "", "")
    " echom printf("atx header level: %s", l:cur_level)
  endif

  if l:new_level == "+"
    let l:new_level = l:cur_level + 1
    " echom printf("+ l:new_level: %s", l:new_level)
  elseif l:new_level == "-"
    let l:new_level = l:cur_level - 1
    " echom printf("- l:new_level: %s", l:new_level)
  endif

  " insert atx headers for levels 3-6
  if l:new_level >= 3 && l:new_level <= 6
    let l:header_text = repeat("#", l:new_level) . " " . l:header_text
  endif

  " insert setex headers for levels 1 or 2
  if l:new_level =~ '[12]'
    let l:chars = ["=", "-"]
    call append(l:cur_lineno, [ repeat(l:chars[l:new_level - 1], strlen(l:header_text)) ])
  endif

  " update the original header line
  call setline(l:cur_lineno, l:header_text)

  " echom l:header_text


endfunction
command! -nargs=1 Header call Header(<f-args>)

function! List() abort
  " echom "List()"
let l:command = 's/\v^\s*(.+)/* \1/e'

  " echom printf("command: %s", l:command)

  execute l:command
  nohlsearch

endfunction

function! Link() abort
  " echom "Link()"

  let l:command = 's/\v^(.*)$/[](\1)/'

  " echom printf("command: %s", l:command)

  execute l:command
  nohlsearch
endfunction

function! TableCreate() abort
  echom "TableCreate(): Create table from section"

  execute 'normal {jj'  |" go to the second line of this section

  " remove it if it is an existing dash divider line
  let l:divline = getline('.')
  if match(divline, '^[-| ]\+$') == 0
    execute 'normal dd'
  endif


  execute 'normal vip'                             |" select the current paragraph
  " call ReplaceEnclosedChar("\`", "|", "X")       |" replace all | chars inside of `` with placeholder

  execute 'normal vip'                             |" select the current paragraph
  execute "normal :EasyAlign *|\r"                 |" align the bar seperated columns
  execute 'normal {j'                              |" go to the first line in the paragraph
  execute 'normal yyPjV'                           |" copy and select it
  execute "normal :s/[^|]/-/\r"                    |" replace all non-bar characters with dashes

  " execute 'normal vip'                             |" select the current paragraph
  " execute ReplaceEnclosedChar("`", "┆", "|")       |" replace placeholder with |

  " execute "normal ''"                    |" return to beginning of last line
  execute 'normal ``'                              |" return cursor to last position
  nohlsearch                                       |" unhighlight previous search results
endfunction

function! TableCreateWithHeader() abort
  call TableHeaderAdd()
  call TableTableCreate()
endfunction

" Clear the contents of a row
function! TableRowVoid() abort
  " echom "TableRowVoid()"

  " get the contents of the current line
  let l:divline = getline('.')

  " skip it if it not a table row
  if match(divline, '^\(\s\|[|]\).*\1$') != 0
    echoe "[TableRowVoid()] Skipping: not a table row"
    echoe "[TableRowVoid()] " . divline
    return
  endif

  execute 'normal V'                     |" copy and select the current line
  execute "normal :s/[^|]/ /\r"          |" replace all non-bar characters with a space

  execute 'normal ``'                    |" return to last cursor position
  nohlsearch                              " unhighlight previous search results
endfunction

function! TableRowAdd() abort
  " echom "TableRowAdd()"

  " skip it if it is already an empty header row
  let l:divline = getline('.')
  if match(divline, '^[| ]\+$') == 0
    echoe "[TableHeaderAdd()] skipping: already an empty header row"
    return
  endif

  execute 'normal yyp'                   |" go to the first line in the paragraph
  call TableRowVoid()

  execute 'normal ``'                    |" return to last cursor position
  nohlsearch                              " unhighlight previous search results
endfunction

function! TableColumnAdd() abort
  " echom "TableColumnAdd()"

  " skip it if it is already an empty header row
  let l:divline = getline('.')
  if match(divline, '^[| ]\+$') == 0
    echoe "[TableHeaderAdd()] skipping: already an empty header row"
    return
  endif

  execute 'normal vip'                   |" select the section
  execute ":s/$/ |/\r"                   |" insert bars at the end of every line
  call TableCreate()                     |" reformat the table

  execute 'normal ``'                    |" return to last cursor position
  nohlsearch                              " unhighlight search results
endfunction

function! TableHeaderAdd() abort
  " echom "TableHeaderAdd()"

  execute 'normal {j'  |" go to the first line of this section

  " get the contents of the current line
  let l:divline = getline('.')

  " skip it if it not a table row
  if match(divline, '^\(\s\|[|]\).*\1$') != 0
    echoe "[TableHeaderAdd()] skipping: not a table row"
    return
  endif

  " skip it if it is already an empty header row
  let l:divline = getline('.')
  if match(divline, '^[| ]\+$') == 0
    echoe "[TableHeaderAdd()] skipping: already an empty header row"
    return
  endif

  execute 'normal {j'                    |" go to the first line in the paragraph
  execute 'normal yyP'                   |" copy and select the current line

  call TableRowVoid()

  execute 'normal ``'                    |" return to last cursor position
  nohlsearch                              " unhighlight previous search results
endfunction

vnoremap <Leader>mb :call Bold()<CR>

vnoremap <Leader>mb :call Bold()<CR>

nnoremap <Leader>ma :call Link()<CR>
vnoremap <Leader>ma :call Link()<CR>

nnoremap <Leader>ml :call List()<CR>
vnoremap <Leader>ml :call List()<CR>

nnoremap <Leader>mal :call Link()<CR> gv :call List()<CR>
vnoremap <Leader>mal :call Link()<CR> gv :call List()<CR>

nnoremap <Leader>mh+ :Header +<CR>
nnoremap <Leader>mh- :Header -<CR>
nnoremap <Leader>mh0 :Header 0<CR>
nnoremap <Leader>mh1 :Header 1<CR>
nnoremap <Leader>mh2 :Header 2<CR>
nnoremap <Leader>mh3 :Header 3<CR>
nnoremap <Leader>mh4 :Header 4<CR>
nnoremap <Leader>mh5 :Header 5<CR>
nnoremap <Leader>mh6 :Header 6<CR>

nnoremap <Leader>mtt :call TableCreate()<CR>
nnoremap <Leader>mtT :call TableCreateWithHeader()<CR>
nnoremap <Leader>mth :call TableHeaderAdd()<CR>
nnoremap <Leader>mtr :call TableRowAdd()<CR>
nnoremap <Leader>mtc :call TableColumnAdd()<CR>
nnoremap <Leader>mtv :call TableRowVoid()<CR>
