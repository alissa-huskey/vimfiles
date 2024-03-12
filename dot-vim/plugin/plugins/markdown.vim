" Markdown.vim  {{{

" disable header folding
let g:vim_markdown_folding_level = 2
" let g:vim_markdown_folding_disabled = 1

" do not use conceal feature, the implementation is not so good
let g:vim_markdown_conceal = 0

" disable math tex conceal feature
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" support front matter of various format
let g:vim_markdown_frontmatter = 1       " YAML format
let g:vim_markdown_toml_frontmatter = 1  " TOML format
let g:vim_markdown_json_frontmatter = 1  " JSON format

let g:vim_markdown_toc_autofit = 1


" enable strikethrough
let vim_markdown_strikethrough = 1

set conceallevel=0

"}}}  / Markdown.vim
