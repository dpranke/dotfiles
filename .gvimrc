set guioptions=egmrLt
set ruler

if has("gui_win32")
  set guifont=Consolas:h11
  set bg=dark
  colorscheme peaksea
  hi ColorColumn guibg=#101010
  set lines=66
elseif has("gui_gtk2") || has("gui_gnome") 
  set guifont=Inconsolata\ Medium\ 12
  set bg=dark
  colorscheme peaksea
  hi ColorColumn guibg=#101010
  set lines=66
elseif has("gui_macvim")
  set guifont=Inconsolata:h16
  hi ColorColumn guibg=#f0f0f0
  set lines=66
endif

" vim:tw=78:sw=4:ts=4:ft=vim:norl:
