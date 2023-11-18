set guioptions=egmrLt
set ruler

if has("macunix")
  set guifont=Inconsolata-Regular:h16
elseif has("unix")
  set guifont=Inconsolata\ 13
endif

set lines=60
set columns=85
set bg=light
hi ColorColumn guibg=#d0d0d0

" vim:tw=78:sw=4:ts=4:ft=vim:norl:
