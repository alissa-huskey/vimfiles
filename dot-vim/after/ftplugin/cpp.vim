" # C++
"

" general {{{

autocmd FileType cpp setlocal wildignore+=build/*

" }}} / general

" {{{ syntastic
"
if get(g:, 'loaded_syntastic_plugin', 1)
  " autocmd FileType sh let g:syntastic_quiet_messages = { "level" : "warnings" };

  if !exists("g:syntastic_cpp_include_dirs")
    let g:syntastic_cpp_include_dirs = []
  endif
  let g:syntastic_cpp_include_dirs += [ 'includes', 'vendor', 'inc', 'src', 'tests' ]

  let g:syntastic_cpp_check_header = 1

  if !exists("g:syntastic_cpp_compiler")
    let g:syntastic_cpp_compiler = 'g++'
  endif

  let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
  let g:syntastic_cpp_auto_refresh_includes = 1
endif

"if get(g:, 'loaded_syntastic_plugin', 1)

"  let includes_file="./.syntastic-includes.vim"
"  if filereadable("./.syntastic-includes.vim")
"    source ./.syntastic-includes.vim
"  endif

"  let g:syntastic_c_include_dirs = g:syntastic_cpp_include_dirs
"end

" }}} / syntastic

" omnicomplete {{{

" configure tags - add additional tags here or comment out not-used ones
" setlocal tags+=~/.vim/tags/cpp
" setlocal tags+=~/.vim/tags/gl
" setlocal tags+=~/.vim/tags/sdl
" setlocal tags+=~/.vim/tags/qt4
" build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
setlocal completeopt=menuone,menu,longest,preview
" "let g:clang_cpp_completeopt = 'menuone,preview'

" }}} / omnicomplete
