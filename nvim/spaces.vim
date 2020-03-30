" Spaces, Tabs, and Indents configs

set tabstop=4 " number of visual spaces per TAB
set softtabstop=4 "number of spaces in TAB when editing
set shiftwidth=4 " when shifting indent using 4 spaces
set shiftround " when shifting line, round the indentaion to the nearest multiple of shiftwidth
set expandtab " TABs are expanded to spaces
set smarttab " be smart when using TABs ;)
set autoindent " New lines inherit the indentation of the previous lines
set smartindent " smart auto indenting when starting a new line

" show different types of white spaces
set list
set listchars=tab:›\ ,eol:¬,trail:•,extends:❯,precedes:❮,nbsp:.
set showbreak=↪

" Different tab/space stops for different file types"
autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd Filetype css setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd Filetype scss setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd Filetype json setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd Filetype javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType make setlocal noexpandtab


