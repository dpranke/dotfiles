set guioptions=egmrLt
set ruler
set lines=60
set columns=85

if has("macunix")
  set bg=light
  set guifont=Inconsolata-Regular:h16
  set linespace=2
  hi ColorColumn guibg=#d0d0d0
elseif has("unix")
  set bg=dark
  set guifont=Inconsolata\ 13
  set linespace=0
  colorscheme peaksea
  hi ColorColumn guibg=#404040
endif

" vim:tw=78:sw=4:ts=4:ft=vim:norl:
