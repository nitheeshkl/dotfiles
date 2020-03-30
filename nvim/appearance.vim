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
set wildmode=list:longest " complete files like a shell
set wildignore=*.o,*~,*.pyc,*.bak " ignore compiled files
set shell=$SHELL
set foldcolumn=1 " add a bit of margin to the left
set laststatus=2 " always display the status bar
set mouse=a " enable mouse for scrolling and resizing
set title " set the window's title, reflecting the file currently being edited
set background=dark " use colors that suit a dark background
set ttyfast " speed up scrolling in vim
set t_Co=256 " Explicitly tell vim that terminal supports 256 colors

" switch cursor to line when in insert mode, and block when not
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
\,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
\,sm:block-blinkwait175-blinkoff150-blinkon175

if &term =~ '256color'
    " disable background color erase
    set t_ut=
endif

" 24 bit color support is configured in the onedark colorscheme plugin.
" enable 24 bit color support if supported
"if (has("termguicolors"))
"    if (!(has("nvim")))
"        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"    endif
"    set termguicolors
"endif

" highlight conflicts
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" line number colors
highlight LineNr ctermfg=grey ctermbg=black

" No annoying sounds on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Text rendering options
set display+=lastline " always try to show a paragraph's last line
set encoding=UTF-8 " use an encoding that supports unicode
set linebreak " avoid wrapping a line in the middle of a word
set showbreak=… " show ellipsis at breaking
set scrolloff=1 " the number of screen line ot keep above and below the cursor
set sidescrolloff=5 " the number of screen columns to keep to the left and right of the cursor
set wrap " enable line wrapping

set textwidth=80 " max text width per line
" set colorcolumn=80
" set the color of the textwidth column
" highlight ColorColumn ctermbg=darkgrey
" TODO: toggle textwidth column based on file and keymapping

set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)

" set diffopt+=vertical,iwhite,internal,algorithm:patience,hiddenoff
set updatetime=300
set signcolumn=yes
set shortmess+=c
