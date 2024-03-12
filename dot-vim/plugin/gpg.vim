" Armor files
" set GPG to armor files for transmission over a text only medium, in other
" words you can send any files it creates over email fine.
let g:GPGPreferArmor = 1

let g:GPGDefaultRecipients = ["alissa@jabberwockey"]

" if nothing happens in an encrypted file for 12 seconds Vim will quit. This
" stops me accidentally leaving a secure file unencrypted when I leave my desk
" doesn't work without modeline: " vim ft=gpg
" also quits immediately on some files for no apparent reason
" augroup GPG
"     autocmd!
"     autocmd FileType gpg setlocal updatetime=12000
"     autocmd CursorHold *.\(gpg\|asc\|pgp\) quit
" augroup END
