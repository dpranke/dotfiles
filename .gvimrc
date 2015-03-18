set guioptions=egmrLt
set ruler

if has("gui_win32")
  set guifont=Consolas:h11
  set bg=dark
  colorscheme peaksea
  " colorscheme solarized
  hi ColorColumn guibg=#101010
  set lines=66
elseif has("gui_gtk2")
  set guifont="DejaVu Sans Mono:h10"
  set bg=dark
  colorscheme peaksea
  " colorscheme solarized
  hi ColorColumn guibg=#101010
  set lines=66
elseif has("gui_macvim")
  set guifont=Inconsolata:h16
  " colorscheme solarized
  hi ColorColumn guibg=#f0f0f0
  set lines=66
elseif has("gui")
  " is this block used?
  set guifont=Inconsolata:h24
  set bg=dark
  " colorscheme solarized
  hi ColorColumn guibg=#101010
  set lines=66
endif


" vim:tw=78:sw=4:ts=4:ft=vim:norl:
