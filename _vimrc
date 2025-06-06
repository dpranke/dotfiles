if has("gui_win32")
  if filereadable("c:\Users\dpranke\AppData\Local\Programs\Python\Python312\python312.dll")
    set pythonthreedll=c:\Users\dpranke\AppData\Local\Programs\Python\Python312\python312.dll
    set pythonthreehome=c:\Users\dpranke\AppData\Local\Programs\Python\Python312
  endif
endif

" Do case-insensitive searching by default.
set ignorecase

" Let backspace move across line boundaries.
set backspace=indent,eol,start

set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set shiftround
set textwidth=0
set mouse=a
set paste
set number

set ruler
set laststatus=2

" Turn off welcome message when starting Vim w/o a file.
set shortmess+=I

" Display a column at 80 characters to indicate long lines.
set colorcolumn=80

" Make tabs visible with the triangle, and show trailing whitespace with the
" dot. Also, highlight trailing whitespace.
set listchars=tab:▸\ ,trail:·
set list
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

syntax on

" Don't expand tabs in makefiles.
autocmd FileType make setlocal noet

" Set commands to insert and clear debugger breakpoints in Python code.
autocmd FileType python nmap ,d Oimport pdb; pdb.set_trace()<ESC>:w
autocmd FileType python nmap ,D dd:w

" Strip trailing whitespace when writing out the file.
autocmd BufWritePre <buffer> %s/\s\+$//e

" Leave insert mode by pressing j-j instead of <esc>.
imap jj <Esc>

" Type `,` to start a map-based command
let mapleader = ","

" Don't show these types of files when autocompleting filenames.
set wildignore=*.o,*.pyc

set hidden

" Change all windows to directory of file in the buffer.
" %p - full path of filename
" %h - head (dirname) of full path
command! CD cd %:p:h

" Change to directory of the file in the buffer (only this window).
command! LCD lcd %:p:h

set splitbelow
set splitright

" Make crontab edit-in-place work.
au BufEnter /private/tmp/crontab.* setl backupcopy=yes

" Ensure that we get the correct indentation for python from our plugins.
filetype plugin indent on

" tweak YouCompleteMe settings
"
" TODO: figure out if I want these.
nmap <leader>d <plug>(YCMHover)
nmap <leader>f :YcmCompleter Format<CR>
nmap <leader>g :YcmCompleter GoTo<CR>
let g:ycm_auto_hover = ''
let g:ycm_clangd_uses_ycmd_caching = 0
"
"" Figure out where clangd is
if has("macunix")
  let g:ycm_clangd_binary_path = "/Users/dpranke/Documents/src/c/src/third_party/llvm-build/Release+Asserts/bin/clangd"
endif
"if filereadable(expand("~/.vimrc.local"))
"  source ~/.vimrc.local
"endif
"let g:ycm_clanged_uses_ycmd_caching=0
"let g:ycm_clangd_binary_path="c:\src\c\src\third_party\llvm-build\Release+Asserts\bin"
"noremap <Leader>f :YcmCompleter Format<CR>


" Save session state per-directory so it can automatically be resumed
" after a restart. Sessions will not be resumed if you start vim w/ args.
function! MakeSession()
  let b:sessiondir = getcwd() . "/.vim"
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (isdirectory(b:sessiondir))
    exe "mksession! " . b:sessionfile
    echo "Saved session."
  else
    echo "Did not save session."
  endif
endfunction

function! LoadSession()
  let b:sessiondir = getcwd() . "/.vim"
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (isdirectory(b:sessiondir) && filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

" Adding automatons for when entering or leaving Vim
if (argc() == 0)
  au VimEnter * nested :call LoadSession()
endif
au VimLeave * :call MakeSession()

" If you uncomment this, vim will redirect any runtime logging/error messages
" to the specified file. This is useful if you're getting messages on exit
" that you don't have time to read.
" au VimLeave :redir! > $HOME/vim_messages.txt
