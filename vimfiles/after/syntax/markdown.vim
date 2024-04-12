" New error pattern without the underscore. The default pattern
" is overly aggressive and will show `*_*` in red, meaning that
" any word with an underscore in the middle is marked as an error.
" See https://stackoverflow.com/questions/19137601/turn-off-highlighting-a-certain-pattern-in-vim
syn match markdownError "\w\@<=\w\@="
