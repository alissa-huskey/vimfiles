" https://github.com/nathanaelkane/vim-indent-guides
IndentGuidesEnable

let g:pymode_run_key = 'R'       " Set key 'R' for run python code
" let g:pymode_run_key = '<leader>r'

let g:pymode_doc_key = 'K'       " Key for show python documentation

let g:pymode_lint_on_write = 0   " Disable pymode auto linting in favor of syntastic

" let g:pymode_lint_checkers = []
let g:syntastic_python_checkers = ['flake8']

" enable docstring auto-close (''':''' or """:""")
let delimitMate_nesting_quotes = ['"', "'"]

" ----------------------------------------------------------------------------------------
" delimitMate_smart_quotes {{{
"
" default:
" '\%(\w\|[^[:punct:][:space:]]\|\%(\\\\\)*\\\)\%#\|\%#\%(\w\|[^[:space:][:punct:]]\)'
"

" ########## regex psudo-dsl ##########
"
" syntactic sugar - empty strings to relationships
let under = ''  " for matching to the character under the cursor
let not = ''    " for when the following pattern is negated
let plus = ''   " for when a characters is followed by another character
let times = ''  " for when the following is a repeating (*?+) modifier

" operator-ish tokens
let or = '\|'
let any = '*'
let cursor = '\%#'

" matching operator-ish tokens
let times_ = '{'
let _times = '}'
let group_  = '\%('
let _group = '\)'

" matching, toggling operator-ish tokens
"    note: these are switched here due to the behavior of
"    delimitMate_smart_quotes
let not_ = '['
let _not = ']'
let is_  = '[^'
let _is  = ']'

" characters
let char_word = '\w'
let char_backslash = '\\'

" character grups
let char_boundary = '[:punct:][:space:]'

" character sequences
let seq_double_backslash = char_backslash.char_backslash
let seq_backslashed = group_.seq_double_backslash._group.times.any . plus .char_backslash

" string/byte literal prefix chars
let char_pre_b = "bB"     " bytes
let char_pre_f = "fF"     " formatted strings (f-strings)
let char_pre_r = "rR"     " raw strings
let char_pre_u = "uU"     " unicode  (python2)
let char_pre = char_pre_b . char_pre_f . char_pre_r . char_pre_u
let seq_pre_r_bf = is_.char_pre_r._is  . plus . is_.char_pre_b.char_pre_f._is
let seq_pre_bf_r = is_.char_pre_b.char_pre_f._is . plus . is_.char_pre_r._is

let pattern  = group_
let pattern .=       is_
let pattern .=           char_boundary
let pattern .=           char_pre
let pattern .=       _is
let pattern .=       or
let pattern .=       group_
let pattern .=           seq_pre_r_bf
let pattern .=           or
let pattern .=           seq_pre_bf_r
let pattern .=       _group
let pattern .=       or
let pattern .=       not_.seq_backslashed._not
let pattern .= _group . plus.cursor
let pattern .= under.cursor . group_
let pattern .=       not.char_word
let pattern .=       or
let pattern .=       is_.char_boundary._is
let pattern .= _group
let delimitMate_smart_quotes = pattern


" "}}} / delimitMate_smart_quotes
" ----------------------------------------------------------------------------------------





