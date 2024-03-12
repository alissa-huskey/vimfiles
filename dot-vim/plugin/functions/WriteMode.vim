function! WriteMode() abort

  " colorscheme unicon
  set background=dark

  let limelight_conceal_ctermfg = 240
  let g:limelight_conceal_guifg = "#585858"

  call pencil#init()
  Goyo
  Limelight

  return 0
endfunction

command! WriteMode call WriteMode()

function! WriteModeLight() abort

  colorscheme unicon
  set background=light

  call pencil#init()
  Goyo
  Limelight

  !printf "\033]1337;SetProfile=Writing\a"

  return 0
endfunction

command! WriteMode call WriteMode()
command! WriteModeLight call WriteModeLight()
