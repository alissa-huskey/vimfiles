let g:syntastic_go_checkers = ['golint', 'govet']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" If you want to add errcheck you can use golangci-lint as a wrapper:

" let g:syntastic_go_checkers = ['golint', 'govet', 'golangci-lint']
" let g:syntastic_go_gometalinter_args = ['--disable-all', '--enable=errcheck']
" let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" Another issue with `vim-go` and `syntastic` is that the location list window
" that contains the output of commands such as `:GoBuild` and `:GoTest` might
" not appear.  To resolve this:
" >
let g:go_list_type = 'quickfix'

" let g:go_statusline_duration = "6000" " 60 seconds
let g:go_statusline_duration = '2'
" let g:go_echo_command_info = 0

nnoremap gc :silent call GoToCode() <CR>
nnoremap gt :silent call GoToTest()<CR>
