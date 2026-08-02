-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.cmd("set showmode")

-- turn off search highlights. nvim's default for this is <C-L>, but that's
-- taken by split navigation below. Mnemonic: `/` is the search key.
vim.keymap.set('n', '<leader>/', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

-- buffers: jump back to the buffer you came from (nvim's built-in <C-^>)
vim.keymap.set('n', '<leader><leader>', '<C-^>', { desc = 'Switch to alternate (last) buffer' })

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

-- window resize submode: <leader>w, then tap h/l (width) and j/k (height)
-- repeatedly like turning a knob; = equalizes; any other key (or Esc) exits.
-- A blocking getchar loop rather than real mappings, so no timeout juggling
-- and the keys can't leak into other buffers.
local resize_keys = {
  h = 'vertical resize -5',
  l = 'vertical resize +5',
  j = 'resize -2',
  k = 'resize +2',
  ['='] = 'wincmd =',
}
vim.keymap.set('n', '<leader>w', function()
  -- Pin the window being resized: getchar() pumps scheduled events while it
  -- waits, so a window opening mid-loop (e.g. neo-tree) could steal focus
  -- and the resize would silently retarget it.
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_echo({
    { ' RESIZE ', 'ModeMsg' },
    { '  h/l width · j/k height · = equalize · any other key exits', 'Normal' },
  }, false, {})
  while true do
    local ok, ch = pcall(vim.fn.getcharstr)
    local cmd = ok and resize_keys[ch]
    if not cmd or not vim.api.nvim_win_is_valid(win) then
      break
    end
    vim.api.nvim_win_call(win, function()
      vim.cmd(cmd)
    end)
    vim.cmd('redraw')
  end
  vim.api.nvim_echo({ { '' } }, false, {})
end, { desc = 'Resize mode (h/l width, j/k height, = equalize)' })

-- tabs key bindings
vim.cmd("map <C-Up> :tabr<CR>")
vim.cmd("map <C-Down> :tabl<CR>")
vim.cmd("map <C-left> :tabp<CR>")
vim.cmd("map <C-right> :tabn<CR>")

-- clipboard
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p', { desc = 'Paste from system clipboard' })

-- jumplist navigation: <C-o>/<C-i> are captured by zellij, so map leader keys.
-- The <C-o>/<C-i> on the RHS run inside nvim, bypassing the terminal entirely.
-- mnemonic: o = older location (back), i = newer location (forward)
vim.keymap.set('n', '<leader>o', '<C-o>', { desc = 'Jumplist: back (older)' })
vim.keymap.set('n', '<leader>i', '<C-i>', { desc = 'Jumplist: forward (newer)' })

-- open the keybindings reference in a read-only vertical split
vim.keymap.set('n', '<leader>?', function()
  local path = vim.fn.stdpath('config') .. '/keybindings.md'
  vim.cmd('vertical sview ' .. vim.fn.fnameescape(path))
end, { desc = 'Show keybindings reference' })
