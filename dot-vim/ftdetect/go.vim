 let g:syntastic_go_checkers = ['golint', 'govet']
 let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

 " let g:syntastic_go_checkers = ['golint', 'govet', 'golangci-lint']
 " let g:syntastic_go_gometalinter_args = ['--disable-all', '--enable=errcheck']
 " let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
" <
" Another issue with `vim-go` and `syntastic` is that the location list window
" that contains the output of commands such as `:GoBuild` and `:GoTest` might
" not appear.  To resolve this:
" >
 let g:go_list_type = "quickfix"
