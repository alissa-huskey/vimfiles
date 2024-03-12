" completion settings
"
" completion configuration and
" settings related to plugins:
"   * snippets engine: ultisnips
"   * additional auto-fill extensions: endwise
"
" Useful references:
" * https://github.com/wincent/wincent/blob/632aa515e22ac7203418c0b597c0ff7de4e15878/aspects/vim/files/.vim/autoload/wincent/autocomplete.vim
" * https://gregjs.com/vim/2016/neovim-deoplete-jspc-ultisnips-and-tern-a-config-for-kickass-autocompletion/
" * :help deoplete#manual_complete

" Snippets mappings
let g:UltiSnipsNoPythonWarning = 1                " disable python warning
let g:UltiSnipsExpandTrigger       = "<nop>"      " <tab>     disable UltiSnips key mappings in favor of SmartTab
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"      " <c-j>
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"      " <c-k>
let g:UltiSnipsListSnippets        = "<c-s>"      " <c-tab>

" tell UltiSnips not to unmap my s-mode mapping (:help UltiSnips-warning-smappings)
let g:UltiSnipsMappingsToIgnore = [ "SmartTab" ]

" Vim completion options

set completeopt+=menuone     " use the completion popup menu even when only one match
set completeopt+=noinsert    " don't insert until user selects
set shortmess+=c             " disable completion messages
set belloff+=ctrlg           " disable beeps during completion
set updatetime=300           " reduce updatetime (default is 4000)

" g:completion - dictionary containing functions and commands for a given
"                completion / snippet engine
"
" engine                 " the completion engine currently in use (one of 'mucomplete', or 'deoplete')
" cr                     " send in place of <cr> when in a completion menu
" can_complete           " check if completion is available
" trigger                " triggers completion
" menu_select            " select the snippet and expand
" menu_fwd               " move forward in completion menu
" menu_bwd               " move forward in completion menu
"
let g:completion = {
      \ "engine"        : '',
      \ "can_complete"  : '',
      \ "cr"            : '\<c-y>',
      \ "trigger"       : '\<c-n>',
      \ "menu_select"   : '',
      \ "menu_fwd"      : '\<down>',
      \ "menu_bwd"      : '\<up>',
      \ }

if has("nvim")
  let g:completion.engine = "deoplete"
else
  let g:completion.engine = "mucomplete"
endif

if g:completion.engine == "mucomplete"

  set completeopt+=menuone     " required by mucomplete
  set completeopt+=noinsert    " required for Vim 7.4.775+

  packadd vim-mucomplete

  let g:completion.cr = '<Plug>(MUcompleteCR)'
  let g:completion.trigger = 'mucomplete#ultisnips#expand_snippet("\<cr>")'
  let g:completion.menu_select = 'mucomplete#ultisnips#expand_snippet("\<cr>")'
  let g:completion.menu_fwd = "<plug>(MUcompleteFwd)"
  let g:completion.menu_bwd = "<plug>(MUcompleteBwd)"

  let g:mucomplete#chains = { 'default': ['ulti', 'keyn'] }

elseif g:completion.engine == "deoplete"

  " let g:completion.can_complete  = 'deoplete#can_complete()'
  let g:completion.can_complete  = "has_key(get(g:, 'deoplete#_context', {}), 'candidates')"
  let g:completion.trigger       = 'deoplete#manual_complete()'
  let g:completion.menu_select   = 'deoplete#close_popup()'
  let g:completion.menu_fwd      = '\<down>'
  let g:completion.menu_bwd      = '\<up>'

  let g:deoplete#enable_at_startup = 1                    " enable deocomplete
  let g:deoplete#disable_auto_complete = 1                " don't complete while typing

  " auto close preview windows
  " autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

  packadd deoplete.nvim

  " call deoplete#enable_logging('DEBUG', 'deoplete.log')  " enable debug logging
  " call deoplete#custom#option('profile', v:true)         " print time in debug log

  " add ultisnips as a source
  call deoplete#custom#source('ultisnips', {'rank': 1000, 'mark': '[snip]'})

  " sources to enable (_ is default)
  call deoplete#custom#option('sources', {
  \ '_': ['ultisnips', 'omni'],
  \})

  " sources to disable (_ is default)
  call deoplete#custom#option('ignore_sources', {
        \ '_': ['around', 'buffer'],
        \ })
endif

" MapCR() -- insert mode mapping of <CR>
"
" Note: Must be called from after/*.vim
"
function! MapCR() abort

  " Note: <expr>-UltiSnips#ExpandSnippet() throws `E533: Not allowed here`.
  " https://github.com/kaile256/dotfiles/blob/9bce150819ee72efc3f0593e528bfc60a3d9b2f8/.config/nvim/dein/add/ultisnips.vim
  inoremap <silent> <Plug>InsertEnter <C-r>=ExpandOrEnter() <cr>

  " leaving this as imap instead of inoremap allows endwise
  " append/prepend to it
  imap <CR> <Plug>InsertEnter

endfunction

" ExpandOrEnter - function mapped to <CR> in insert mode
"
" In a completion menu expand the completion or snippet. Otherwise, insert a
" normal <CR>.
"
" depends on
" ----------
" g:completion.menu_select - completion engine function that expands the
"                            selected completion
"
function! ExpandOrEnter()
  " try expanding the UltiSnips snippet
  let g:ulti_expand_res = 0
  call UltiSnips#ExpandSnippet()

  if g:ulti_expand_res != 0
    " echom "snippet expanded"
    " the snippet was expanded, done
    return ""
  endif
  "
  " echom "no snippet expanded"

  " expand the selected completion
  if pumvisible() && g:completion.menu_select != ""
    exec "return " . g:completion.menu_select
  endif

  " all other cases fall back to a normal <CR>
  return "\<CR>"

endfunction


" MapTAB() -- insert mode mapping of <TAB> and <S-TAB>
"
" depends on
" ----------
"  - g:completion.menu_bwd
"
" Note: Must be called from after/*.vim
"
function! MapTAB() abort

  exec 'imap <expr> <S-TAB> ( pumvisible() ? "' . g:completion.menu_bwd . '" : "\<S-TAB>" )'

  imap <silent><expr> <Tab> SmartTab()
  snoremap <silent> <Tab> <Esc> :call g:SmartTab()<cr>

  " also trigger completion with <C-N> (for debugging)
  exec 'imap <expr> <C-N> ' . g:completion.trigger

endfunction

" SmartTab() - function mapped to <TAB> in insert mode
"
" Tab behavior:
" - in a completion menu, go down in the list
" - if completion is available, trigger completion menu
" - if in a snippet, jump forward
" - finally, fallback to a normal <TAB>
"
" depends on
" ----------
"  - g:completion.menu_fwd
"  - g:completion.can_complete (optional)
"  - g:completion.trigger (required if g:completion.can_complete is present)
"
function! SmartTab()
  " if in the completion menu, navigate to the next option
  if pumvisible()
    exec 'return "' . g:completion.menu_fwd . '"'
  endif

  " if completion is available, trigger completion
  if g:completion.can_complete != ""
    exec 'let l:can_complete = ' . g:completion.can_complete

    if l:can_complete
      exec "return " . g:completion.trigger
    endif
  endif

  " try jumping forward in a snippet
  call UltiSnips#JumpForwards()
  if g:ulti_jump_forwards_res == 1

    " clear for next jump
    let g:ulti_jump_forwards_res = 0

    " jump was successful, we're done
    return ""
  endif

  " all other cases fall back to a normal <TAB>
  return "\<TAB>"

endfunction
