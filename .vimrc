" do case-insensitive searching
set ignorecase

" backspace across line boundaries
set backspace=indent,eol,start

set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set shiftround
set textwidth=0
set mouse=a
set paste
set number

set ruler
set laststatus=2

" turn off welcome message when starting Vim w/o a file
set shortmess+=I

" display a column at 80 characters to indicate long lines
set colorcolumn=80

syntax on

" don't expand tabs in makefiles
autocmd FileType make setlocal noet sw=4 ts=4

" use 4-spaces in Python (PEP-8 style)
autocmd FileType python setlocal sw=4 ts=4

" set commands to insert and clear debugger breakpoints
autocmd FileType python nmap ,d Oimport pdb; pdb.set_trace()<ESC>:w
autocmd FileType python nmap ,D dd:w

" strip trailing whitespace.
autocmd BufWritePre <buffer> %s/\s\+$//e

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

" make crontab edit-in-place work
au BufEnter /private/tmp/crontab.* setl backupcopy=yes

" Ensure that we get the correct indentation for python from our plugins
filetype plugin indent on
