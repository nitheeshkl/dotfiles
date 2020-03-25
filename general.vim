let mapleader="," " leader is a comma
syntax enable    " enable syntax processing
set nocompatible " use vim settings instead of vi settings.
set autoindent   " copy indent from current line
set smartindent  " smart autoindenting when starting a new line
set autoread     " read open files again when changed outside vim
set autowrite    " write a modified buffer on each :next, ...
set ruler        " show the cursor position all the time
set showcmd      " display incomplete commands
set visualbell   " visual bell instead of beeping
set number       " show line numbers
set cursorline   " show a horizontal line for the cursor
set mouse=a      " enable the use of mouse
set textwidth=80 " max text width per line
set wildmenu     " command-line completion in an enhanced mode
set wildignore=*.bak,*.o,*.e,*~ " ignore these file extensions for wildmenu
set backspace=indent,eol,start " backspacing over everything in insert mode
set browsedir=current " which directory to use for the file browser
set popt=left:8pc,right:3pc " print options
