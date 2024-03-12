" nfo
" (media information files)
" ---

" Necessary for multiple encodings
setlocal encoding=utf-8

" Common code for encodings
function! SetFileEncodings(encodings)
let b:myfileencodingsbak=&fileencodings
let &fileencodings=a:encodings
endfunction
function! RestoreFileEncodings()
let &fileencodings=b:myfileencodingsbak
unlet b:myfileencodingsbak
endfunction

" .NFO specific
au BufReadPre *.nfo call SetFileEncodings('cp437')|setlocal ambiwidth=single
au BufReadPost *.nfo call RestoreFileEncodings()

" Q = gq
noremap Q gq
