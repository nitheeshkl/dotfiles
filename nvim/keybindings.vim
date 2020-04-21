" Key mappings

let mapleader=" " " leader is spacebar

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

" turn off search highlights
nnoremap <leader><space> :nohlsearch<CR>

" window & splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <silent> <Leader>j :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>k :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>h :exe "vertical resize " . (winwidth(0) * 12/10)<CR>
nnoremap <silent> <Leader>l :exe "vertical resize " . (winwidth(0) * 10/12)<CR>

nnoremap <silent> <Leader>s :split<CR>
nnoremap <silent> <Leader>v :vsplit<CR>

" Open new split panes to right and bottom, which feels more natural than Vim’s default:
set splitbelow
set splitright

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

"nnoremap <C-S-Tab> :tabp<cr>
"nnoremap <C-Tab> :tabn<cr>
"nnoremap <C-n> :tabnew<cr>
"map <C-n> :tabnew<cr>
"map <C-S-Tab> :tabprevious<cr>
"map <C-Tab> :tabnext<cr>
"map <C-x> :tabclose<cr>
"imap <C-S-Tab> <ESC>:tabprevious<cr>i
"imap <C-Tab> <ESC>:tabnext<cr>i
"imap <C-n> <ESC>:tabnew<cr>

