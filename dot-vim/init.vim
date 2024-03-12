" --------------------------------------------------------
" BASIC CONFIG {{{
"
"
" misc {{{

" vint: -ProhibitSetNoCompatible
set nocompatible
" vint: +ProhibitSetNoCompatible
set encoding=utf-8
scriptencoding utf-8

" this may be the thing causing me so much trouble these days
" don't destroy the buffer, just hide it
" set hidden

" Per-directory .vimrc files
set exrc
set secure

" allow reading set commands from modelines of files
set modeline

" }}} / misc

" locations {{{
"

let g:cache_dir=$VIMDIR . '/cache'
let g:plugins_dir=$VIMDIR . '/bundle'       " pathogen
" let g:python3_host_prog  = $HOME . '/.pyenv/versions/3.9.9/bin/python3.9'

" disable mouse support
set mouse=

"
"}}} / locations

" completion {{{
"

" ** enables recursive search for finding files
" works for tab completion, :find
set path=.,/usr/include,,**

"display all matching files when we tab complete
set wildmenu

" the char used for 'expansion' on the command line
set wildchar=<tab>

" command line completion
" longest: complete to the longest common string
" list: list multiple matches
" list:longest complete to the longest common string
" list:full complete the first full match
" set wildmode=list:longest,full
set wildmode=longest,list:full " bash-like tab completion?

set wildignore+=*/.git/**/*,*/.hg/**/*,*/.svn/**/*


" }}} / completion

" searching & substitution {{{
"

" incremental search: search as you type each character
set incsearch

" hightlight search: highlight search results
set hlsearch

" highlight matching parens
set showmatch

" always use global substitutions (%s/<pat>/<rep>/g)
set gdefault

" default to case insensitive search
" override with /\C
set ignorecase

"
" }}} / searching

" session-type config {{{
"

" save more history
set history=10000

let undo_dir = cache_dir . '/undo'
let g:viminfo_dir=cache_dir . '/info'   " viminfo
" let g:viminfo_file=viminfo_dir . '/viminfo'    " viminfo
let g:shada_file=viminfo_dir . '/shada'        " shada

if has('nvim')
  execute 'set shadafile=' . viminfo_dir . '/info/shada'
  set shada +=%                                   " save and restore buffer list
  set shada +='50                                 " marks
  set shada +=:1000                               " command line history
  set shada +="100                                " register lines

  set runtimepath^=$HOME/.vim runtimepath^=$HOME/.vim/plugin runtimepath+=$HOME/.vim/after
  " let &packpath = &runtimepath
else
  let undo_dir = undo_dir . '/classic'                     " "
  execute 'set viminfo +=n' . viminfo_dir . '/viminfo'  | " viminfo filename
  set viminfo +=%                                          " save and restore buffer list
  set viminfo +='50                                        " marks
  set viminfo +=:1000                                      " command line history
  set viminfo +="100                                       " register lines
endif

execute 'set undodir=' . undo_dir
set undofile

execute 'set directory=' . cache_dir . '/swap'

"
" }}} / session-type config

" display options {{{

" show line numbers
set number

" default to nowrap
set nowrap

" show last command executed in the last line of the screen
set showcmd

" highlight cursorline
" set cursorline  # this is being done by iterm now

" enable syntax highlighting
" syntax on

" }}} / display options

" listchars {{{
"

" set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set listchars=""

" tabs
" tab:xy[z]
"   - 'x' is prepended
"   - 'y' as many times as will fit
"   - 'z' is optionally appended
" examples for tabwidth=4
"    tab:>-     >---
"    tab:>-<    >--<
" set listchars+=tab:→\
set listchars+=tab:→\ ┆

" trailing whitespace
set listchars+=trail:~               " trailing whitespace

" eol
set listchars+=eol:¶                 " end of line
" set listchars+=eol:¬
" set listchars+=eol:↴

" space
set listchars+=space:·

" nbsp
" set listchars+=nbsp:␣
set listchars+=nbsp:⣿

" line wrap
" set showbreak=↪\              " end of line
" set listchars+=extends:⟩      " end of line
" set listchars+=precedes:⟨     " beginning of line
set listchars+=extends:»
set listchars+=precedes:«
" set listchars+=extends:▸

" conceal
set listchars+=conceal:…

"
" "}}} / name


" behavior of keys {{{

" backspace should behave like all other apps
set backspace=indent,eol,start

" tabs and indentation
" tabstop: The width of a hard tabstop measured in "spaces" -- effectively the (maximum) width of an actual tab character
" shiftwidth: The size of an "indent". It's also measured in spaces, so if your code base indents with tab characters then you want shiftwidth to equal the number of tab characters times tabstop. This is also used by things like the =, > and < commands.
" softtabstop: Setting this to a non-zero value other than tabstop will make the tab key (in insert mode) insert a combination of spaces (and possibly tabs) to simulate tab stops at this width.
" expandtab: Enabling this will make the tab key (in insert mode) insert spaces instead of tab characters. This also affects the behavior of the retab command.
" smarttab: Enabling this will make the tab key (in insert mode) insert spaces or tabs to go to the next indent of the next tabstop when the cursor is at the beginning of a line (i.e. the only preceding characters are whitespace).
" autoindent: Copy indent from current line when starting a new line
" smartindent: Do smart autoindenting when starting a new line
" cindent: use c style indentation

set tabstop=2 softtabstop=0 expandtab shiftwidth=2
set smarttab smartindent autoindent

" }}} / behavior of keys

" windows {{{

" when opening a split, open a new file below for vertical split, or to the
" right for a horizontal split
set splitbelow
set splitright

" minimal number of screen lines to keep above and below the cursor
set scrolloff=4

" }}} / windows

" comments {{{

" o: (removing) prepend comment char on new line inserted using 'o' or 'O'
set formatoptions-=o

" j: remove a comment leader when joining lines
set formatoptions+=j

" }}} / comments

" colors {{{

" rgb colors
set termguicolors

let g:highlight_long_lines = 0
let g:show_color_col = 0


" }}} / colors

" folds {{{

" default fold method
set foldmethod=marker

" open all folds when opening a new document
set foldlevelstart=20

" clean up the folds
set fillchars=fold:\     " space for fold char, not trailing whitespace

" make a fold column
" if has('nvim')
"   set foldcolumn=auto:4
" else
"   set foldcolumn=4
" endif

" characters for fold column
set fillchars=fold:\ ,foldclose:▶,foldopen:▼,foldsep:┊

" don't fold if 2 lines or less
set foldminlines=2

" highlight Folded guifg=#b0d0e0

" }}} / folds

" }}} / BASIC
" --------------------------------------------------------

" --------------------------------------------------------
" netrw browser {{{
" vims default file browser, :Explore
"

let g:netrw_altfile = 1                            " CTRL-^ opens last edited file (not browser buffer)
let g:netrw_alto = 1                               " split below
let g:netrw_banner =   0                           " remove the heading
let g:netrw_browse_split = 4
" let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'   " hide dotfiles ; (gh to toggle)
let g:netrw_liststyle = 3                          " tree-style list
let g:netrw_sizestyle = 'H'                        " human-readable file sizes
let g:netrw_sort_options = "i"                     " ignore case l=locale
let g:netrw_winsize = 20


" open files in prev window (the one you called explore from)



" }}} / netrw

" --------------------------------------------------------
" PLUGINS {{{
"
" Pathogen  {{{
let g:pathogen_disabled = []

execute pathogen#infect()
filetype plugin indent on  " required

" }}} / Pathogen

" vim-json  {{{

" this sets conceallevel in markdown docs
let g:vim_json_syntax_conceal = 0

" }}} / vim-json

" }}} / PLUGINS
" --------------------------------------------------------

" --------------------------------------------------------
" KEY MAPPINGS {{{
" --------------------------------------------------------

" for additional mappings see also files in directories:
" - plugin/functions
" - plugin/plugins
" - ftplugin

" system shortcuts {{{{
" ----------------
" my custom keyboord shortcuts used system-wide

" insert mode
inoremap <C-a>  <Home>
inoremap <C-e>  <End>
inoremap <M-b>  <S-Left>
inoremap <M-f>  <S-Right>

" command mode
cnoremap <C-a>  <Home>
cnoremap <C-e>  <End>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>

" }}}} system shortcuts

" vim shortcuts {{{{
" -------------
" additional shortcuts to builtin vim commands/mappings

" toggle opening and closing of fold under cursor
nnoremap <space> za

" toggle opening and closing of all folds
nnoremap zz zi

" select previously pasted region
nnoremap gp `[v`]
nnoremap gP `[V`]

" quit all
nnoremap Q :qa<CR>

" quit and save all
nnoremap <C-S> :xa<CR>

" quit and don't save all
nnoremap <C-Q> :qa!<CR>

" turn off highighting from previous search
nnoremap // :nohlsearch<CR>

" repeat the last f/F/t/T motion in the opposite direction
" (because I use , as leader)
nnoremap g: ,
vnoremap g: ,

" }}}} / vim shortcuts

" function mappings {{{{
" -------------

" inclusive end of paragraph (don't include one more line)

" }}}} / function shortcuts

" <Leader> mappings {{{{
" -------------

let mapleader = ','

" ,a :AnyFoldActivate (enable anyfold)

" ,c toggle nerdcomment

" ,e open file netrw explorer on the left
nnoremap <Leader>e :20Vexplore<CR>

" ,m<command>
" markdown.vim commands

" ,n open NERDTree
nnoremap <Leader>n :NERDTreeToggle<CR>

" ,o open file fold digest (outline) on right
nnoremap <Leader>f :call FoldDigestToggle()<CR>

" ,p toggle Playground.vim
nnoremap <Leader>p :call playground#toggle()<CR>

" ,s disable syntastic
nnoremap <Leader>s :SyntasticToggleMode<CR>

" ,t toggle tagbar
nnoremap <Leader>t :TagbarToggle<CR>

" switch case
" normal: ,~[LETTER]   t=title, l=lower, u=upper
nnoremap <Leader>~t :ChangeCase n t<CR>
nnoremap <Leader>~l :ChangeCase n l<CR>
nnoremap <Leader>~u :ChangeCase n u<CR>
" visual: ,[LETTER]   t=title, l=lower, u=upper
vnoremap <Leader>t :ChangeCase v t<CR>
vnoremap <Leader>l :ChangeCase v l<CR>
vnoremap <Leader>u :ChangeCase v u<CR>

" jump to brittspace (trailing whitespace)
nnoremap <Leader>w :%s/\s\+$//<CR>

" ,v to reload vimrc
nnoremap <Leader>v :source ${MYVIMRC}<CR>:nohlsearch<CR>

" toggle zoom of window
nnoremap <Leader>z :ZoomToggle<CR>

" }}}} / <Leader> mappings

" plugin mappings {{{{
" -------------

let NERDTreeHijackNetrw=0

" }}}} / plugin mappings



" }}} / KEY MAPPINGS
" --------------------------------------------------------

" --------------------------------------------------------
" TAGS {{{

 " look in the current directory for "tags" then
 " work up the tree towards root until one is found
" set tags=./.tags;/
set tags=./.tags;,.tags

" }}} / TAGS
" --------------------------------------------------------

" --------------------------------------------------------
" VIMDIFF {{{
"

" split vertical, ignore whitespace, show filler lines
set diffopt=vertical,iwhite,filler

"
" }}} / VIMDIFF
" --------------------------------------------------------

" --------------------------------------------------------
" ABBREVIATIONS {{{
"

iabbrev adn  and
iabbrev waht what
iabbrev tehn then
iabbrev teh  the
iabbrev <expr> dts strftime("%Y-%m-%d")
iabbrev <expr> wts strftime("%Y-%m-%d %a")
iabbrev <expr> tts strftime("%Y-%m-%d %a %H:%M")


"
" }}} / ABBREVIATIONS

" --------------------------------------------------------
"

" --------------------------------------------------------
" AUTOGROUPS {{{
"

augroup Global
  autocmd!
  " needs to be done here to avoid race condition errors
  autocmd BufWinEnter * syntax on
  " autocmd BufWinEnter set conceallevel=0
augroup END

augroup TagFileType
  autocmd!
  autocmd FileType * setl tags<
  autocmd FileType * exe 'setl tags+=~/.ctags/' . &filetype . '/*/tags'
augroup END

augroup RestoreCursor
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ |   exe "normal! g`\""
        \ | endif
augroup end

augroup EasyExit
  autocmd!
  autocmd WinEnter * let w:exitcmd = ""
  autocmd QuitPre,BufWinLeave <buffer> let w:exitcmd = histget("cmd", -1)
  " autocmd QuitPre,BufWinLeave <buffer> silent call AutoCloseNonfileBufs()
  " autocmd QuitPre,BufWinLeave <buffer> call AutoCloseNonfileBufs()
augroup end

"
" "}}} / AUTOGROUPS
" --------------------------------------------------------
"

let g:rst_map_keys = 1
