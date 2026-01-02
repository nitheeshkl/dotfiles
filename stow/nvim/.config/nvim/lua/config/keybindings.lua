-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.cmd("set showmode")

-- turn off search highlights
vim.cmd("nnoremap <leader><space> :nohlsearch<CR>")

-- window & splits
vim.cmd("nnoremap <C-J> <C-W><C-J>")
vim.cmd("nnoremap <C-K> <C-W><C-K>")
vim.cmd("nnoremap <C-L> <C-W><C-L>")
vim.cmd("nnoremap <C-H> <C-W><C-H>")

vim.cmd("nnoremap <silent> <leader>s :split<CR>")
vim.cmd("nnoremap <silent> <leader>v :vsplit<CR>")

-- window/pane navigation
vim.keymap.set('n', '<leader><Up>', '<C-W>k')
vim.keymap.set('n', '<leader><Down>', '<C-W>j')
vim.keymap.set('n', '<leader><Left>', '<C-W>h')
vim.keymap.set('n', '<leader><Right>', '<C-W>l')

-- tabs key bindings
vim.cmd("map <C-Up> :tabr<CR>")
vim.cmd("map <C-Down> :tabl<CR>")
vim.cmd("map <C-left> :tabp<CR>")
vim.cmd("map <C-right> :tabn<CR>")

-- clipboard
vim.keymap.set('v', '<leader>y', '"+y')
