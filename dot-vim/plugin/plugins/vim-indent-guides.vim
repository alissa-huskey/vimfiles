" https://github.com/nathanaelkane/vim-indent-guides

" indent level to start showing guides from (default: 1)
" let g:indent_guides_start_level = 1

" how many indent levels to display guides for (default: 30)
let g:indent_guides_indent_levels = 1

" number of spaces to highlight (default: 0)
let g:indent_guides_guide_size = 1

" let g:indent_guides_color_change_percent = 40
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=23 guibg='#001e27'
