" Key mappings

" toggling paste mode
nnoremap <C-v> :set invpaste paste?<CR>
set pastetoggle=<C-v>
set showmode

" autocomplete parenthesis, brackets and braces
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
vnoremap ( s()<Esc>P<Right>%
vnoremap [ s[]<Esc>P<Right>%
vnoremap { s{}<Esc>P<Right>%

" autocomplete quotes (visual and select mode)
xnoremap  '  s''<Esc>P<Right>
xnoremap  "  s""<Esc>P<Right>
xnoremap  `  s``<Esc>P<Right>


" tabs key bindings
map <C-Up> :tabr<cr>
map <C-Down> :tabl<cr>
map <C-left> :tabp<cr>
map <C-right> :tabn<cr>

"map ESC[1;3C] <A-right>
"map ESC[1;3D] <A-left>

"map <C-S-Tab> :tabprevious<CR>
"nmap <C-S-Tab> :tabprevious<CR>
"imap <C-S-Tab> <Esc>:tabprevious<CR>i
"map <C-Tab> :tabnext<CR>
"nmap <C-Tab> :tabnext<CR>
"imap <C-Tab> <Esc>:tabnext<CR>i

:nmap <C-S-tab> :tabprevious<cr>
:nmap <C-tab> :tabnext<cr>
:nmap <C-n> :tabnew<cr>
:map <C-n> :tabnew<cr>
:map <C-S-tab> :tabprevious<cr>
:map <C-tab> :tabnext<cr>
:map <C-x> :tabclose<cr>
:imap <C-S-tab> <ESC>:tabprevious<cr>i
:imap <C-tab> <ESC>:tabnext<cr>i
:imap <C-n> <ESC>:tabnew<cr>

