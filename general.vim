let mapleader="," " leader is a comma
syntax enable    " enable syntax processing
set nocompatible " use vim settings instead of vi settings.
set autoread     " read open files again when changed outside vim
set autowrite    " write a modified buffer on each :next, ...
set backspace=indent,eol,start " backspacing over everything in insert mode
set browsedir=current " which directory to use for the file browser
set popt=left:8pc,right:3pc " print options
set history=500 " how many lines of history vim has to remember
set magic " turn on magic for regular expression matching
set ffs=unix,dos,mac " use unix as the standard file type
set noswapfile " disable swapfile

" clipboard
if has("unnamedplus")
    set clipboard=unnamedplus
elseif has("clipboard")
    set clipboard=unnamed
endif

