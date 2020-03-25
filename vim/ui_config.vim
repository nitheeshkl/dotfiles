" UI and visual configurations

set number " show line numbers
set showmode
set showcmd " show command in bottom/status bar
set cursorline " highlight current line
set lazyredraw " redraw only when needed
set showmatch " highlight matching paranthesis [{()}]
set matchpairs+=<:> " highlight matching pairs of brackets. use '%' to jump between them.
set mat=2 " how many tenths of a second to blink when matching paranthesis
set so=7 " set 7 lines to the cursor when moving vertically using j/k
set ruler " always show current position
set cmdheight=1 " height of the command bar
set hid " buffer becomes hidden when it is abandoned
set wildmenu " visual autocomplete for command menu
set wildignore=*.o,*~,*.pyc,*.bak " ignore compiled files
set foldcolumn=1 " add a bit of margin to the left
set laststatus=2 " always display the status bar
set mouse=a " enable mouse for scrolling and resizing
set title " set the window's title, reflecting the file currently being edited
set background=dark " use colors that suit a dark background
set ttyfast " speed up scrolling in vim

" line number colors
highlight LineNr ctermfg=grey ctermbg=black

" No annoying sounds on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Text rendering options
set display+=lastline " always try to show a paragraph's last line
set encoding=utf-8 " use an encoding that supports unicode
set linebreak " avoid wrapping a line in the middle of a word
set scrolloff=1 " the number of screen line ot keep above and below the cursor
set sidescrolloff=5 " the number of screen columns to keep to the left and right of the cursor
set wrap " enable line wrapping

set textwidth=80 " max text width per line
" set colorcolumn=80
" set the color of the textwidth column
" highlight ColorColumn ctermbg=darkgrey
" TODO: toggle textwidth column based on file and keymapping

set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)
