-- Spaces, Tabs, and Indents configs

-- Apply project .editorconfig settings (built-in since nvim 0.9, on by default).
-- Set explicitly so the behavior is documented and can't be silently disabled.
vim.g.editorconfig = true

vim.cmd("set tabstop=4") -- number of visual spaces per TAB
vim.cmd("set softtabstop=4") -- number of spaces in TAB when editing
vim.cmd("set shiftwidth=4") -- when shifting indent using 4 spaces
vim.cmd("set shiftround") -- when shifting line, round the indentaion to the nearest multiple of shiftwidth
vim.cmd("set expandtab") -- TABs are expanded to spaces
vim.cmd("set smarttab") -- be smart when using TABs ;)
vim.cmd("set autoindent") -- New lines inherit the indentation of the previous lines
vim.cmd("set smartindent") -- smart auto indenting when starting a new line

-- show different types of white spaces
vim.cmd("set list")
vim.cmd("set listchars=tab:›\\ ,eol:¬,trail:•,extends:❯,precedes:❮,nbsp:.")
vim.cmd("set showbreak=↪")

-- Different tab/space stops for different file types"
vim.cmd("autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab")
vim.cmd("autocmd Filetype html setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab")
vim.cmd("autocmd Filetype css setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab")
vim.cmd("autocmd Filetype scss setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab")
vim.cmd("autocmd Filetype json setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab")
vim.cmd("autocmd Filetype javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab")
vim.cmd("autocmd FileType make setlocal noexpandtab")

-- enable syntax processing
vim.cmd("syntax enable")
-- use vim settings instead of vi settings.
vim.cmd("set nocompatible")
-- read open files again when changed outside vim
vim.cmd("set autoread")
-- write a modified buffer on each :next, ...
vim.cmd("set autowrite")
-- backspacing over everything in insert mode
vim.cmd("set backspace=indent,eol,start")
-- how many lines of history vim has to remember
vim.cmd("set history=500")
-- turn on magic for regular expression matching
vim.cmd("set magic")
-- use unix as the standard file type
vim.cmd("set ffs=unix,dos,mac")
-- disable swapfile
vim.cmd("set noswapfile")

--show results of substitution as they're happening but don't open a split
vim.cmd("set inccommand=nosplit")

-- clipboard
-- Use OSC 52 so yanking to the system clipboard works over SSH/TTY sessions
-- (where xclip/xsel can't reach an X server). The terminal handles the actual
-- clipboard write via an escape sequence.
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}

-- Enable file type detection. Use the default filetype settings.
-- Also load indent files, to automatically do language-dependent indenting.
vim.cmd("filetype plugin on")
vim.cmd("filetype indent on")

-- Backup Rules
-- as annoying as it is to have vim complain for trying to edit a file that is
-- already being edit, it is much better than losing tons of work in an
-- edited-but-not-written file
vim.cmd("set backup")
vim.cmd("set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp")
vim.cmd("set backupskip=/tmp/*")
vim.cmd("set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp")
vim.cmd("set writebackup")

-- Line numbers
vim.cmd("set number") -- show absolute number on the current line
vim.cmd("set relativenumber") -- show relative numbers on all other lines

-- Search settings
vim.cmd("set incsearch") -- search as characters are entered
vim.cmd("set hlsearch") -- highlight search matches
vim.cmd("set ignorecase") -- ignore case when searching
vim.cmd("set smartcase") -- when searching try to be smart about cases
