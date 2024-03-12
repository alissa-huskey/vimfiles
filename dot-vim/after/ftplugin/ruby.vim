" Ruby
"

packadd! vim-ruby
packadd! vim-rake
packadd! vim-bundler

"
" omnicomplete {{{

setlocal omnifunc=syntaxcomplete#Complete

" if has("autocmd")
au BufRead,BufNewFile {Gemfile,Gemfile.local,Rakefile,Thorfile,Guardfile,config.ru} setlocal ft=ruby

autocmd FileType ruby compiler ruby

autocmd FileType ruby setlocal omnifunc                       =rubycomplete#Complete
autocmd FileType ruby let g:rubycomplete_buffer_loading       =1
autocmd FileType ruby let g:rubycomplete_classes_in_global    =0
autocmd FileType ruby let g:rubycomplete_include_object       =0
autocmd FileType ruby let g:rubycomplete_include_object_space =0

autocmd FileType ruby let g:ruby_space_errors                 =1
autocmd FileType ruby let g:ruby_fold                         =1
autocmd FileType ruby let g:rubycomplete_rails                =0
autocmd FileType ruby let g:rubycomplete_load_gemfile         =1

" autocmd FileType ruby let g:rubycomplete_use_bundler        =1   " to use Bundler.require instead of Gemfile
" autocmd FileType ruby let g:rubycomplete_load_paths         =["/path/to/code", "./lib/example"] " for custom paths to be added to $LOAD_PATH
" autocmd FileType ruby let g:rubycomplete_gemfile_path       ='Gemfile.aux'

"autocmd FileType css setlocal omnifunc                       =csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc             =htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc                =javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc                    =pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc                       =xmlcomplete#CompleteTags
" endif

" }}} / omnicomplete
"
" syntastic {{{

if get(g:, 'loaded_syntastic_plugin', 1)
autocmd FileType ruby let g:syntastic_ruby_checkers            = [ 'rubocop' ]
autocmd FileType ruby let g:syntastic_ruby_rubocop_args        = '--display-cop-names --only-guide-cops --except "Metrics/LineLength, Style/Documentation, Metrics/MethodLength, Metrics/BlockNesting, Style/HashSyntax, Style/BlockDelimiters, Style/StringLiterals"'
endif

" }}} / syntastic
