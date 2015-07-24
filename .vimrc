
" do case-insensitive searching
set ignorecase

" backspace across line boundaries
set backspace=indent,eol,start

" automatically autoindent and expand tabs by default
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set shiftround
set textwidth=0

" enable mouse support if available
set mouse=a

" expect to get cut&paste from the window manager
" set paste

" always display the ruler and status line by default
set ruler
set laststatus=2

" turn off welcome message when starting Vim w/o a file
set shortmess+=I

" display hidden characters
"use :set list! to toggle visible whitespace on/off
"set list!
"set listchars=tab:,eol:¬

" display a column at 80 characters to indicate long lines
if version >= 703
  set colorcolumn=80
  if &background == "dark"
    "hi ColorColumn guibg=#333 ctermbg=darkgrey
    hi ColorColumn guibg=darkgrey ctermbg=darkgrey
  else
    "hi ColorColumn guibg=#ddd ctermbg=lightgrey
    hi ColorColumn guibg=lightgrey ctermbg=lightgrey
  end
endif

syntax on

" debugging syntax highlighting
autocmd FuncUndefined * exe 'runtime autoload/' . expand('<afile>').'.vim'

"flag problematic whitespace (trailing and spaces before tabs)
"Note you get the same by doing let c_space_errors=1 but
"this rule really applys to everything.
if &background == "dark"
  highlight RedundantSpaces term=standout ctermbg=red guibg=red
else
  highlight RedundantSpaces term=standout ctermbg=yellow guibg=yellow
end
"\ze sets end of match so only spaces highlighted
match RedundantSpaces /\s\+$\| \+\ze\t/

" don't expand tabs in makefiles
autocmd FileType make setlocal noet sw=4 ts=4

" use a 2-char indent in C++ files (Google style)
autocmd FileType cpp  setlocal sw=2 ts=2 tw=0

" don't automatically wrap python source code
autocmd FileType python setlocal tw=0

" set commands to insert and clear debugger breakpoints
autocmd FileType python nmap ,d Oimport pdb; pdb.set_trace()<ESC>:w
autocmd FileType python nmap ,D dd:w

" strip trailing whitespace in C/C++/Python code
autocmd FileType c,cpp,java,python autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

"
" Keyboard mappings
"
nnoremap <silent> <F8> :TlistToggle<CR>

:map <F10> :call SyntaxAttr()<CR>

set pastetoggle=<F10>
":map <F11> :if exists("syntax_on") <Bar>
"     \    syntax off <Bar>
"     \  else <Bar>
"     \    syntax enable <Bar>
"     \  endif <CR>

let Tlist_Display_Tag_Scope = 1

"
" Leave insert mode by pressing j-j instead of <esc>
imap jj <Esc>

let mapleader = ","

set wildignore=*.o,*.pyc

set hidden

" change all windows to directory of file in the buffer
" %p - full path of filename
" %h - head (dirname) of full path
command! CD cd %:p:h

" Change to directory of the file in the buffer (only this window)
command! LCD lcd %:p:h

set splitbelow
set splitright

" Disable MiniBufExplorer for now until I can play with it more
let loaded_minibufexplorer =1

let Tlist_Display_Tag_Scope = 0

" make crontab edit-in-place work
au BufEnter /private/tmp/crontab.* setl backupcopy=yes

" Command-T settings
let g:CommandTMaxFiles=50000

" Ensure that we get the correct indentation for python from our plugins
filetype plugin indent on
