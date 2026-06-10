-- Auto-reload files that were changed on disk by an external tool (formatters,
-- git operations, Claude, etc.). `autoread` is set in vim_options, but on its
-- own it only re-reads when Neovim is prompted to check; these events trigger
-- the actual disk check so changes show up while the buffer is open.
--
-- Safety: this only reloads buffers with NO unsaved changes. If a buffer is
-- modified and the file also changed on disk, Neovim warns about the conflict
-- instead of clobbering your edits.

local group = vim.api.nvim_create_augroup("AutoReadCheck", { clear = true })

-- CursorHold fires after `updatetime` ms of inactivity; lower it so reloads
-- feel near-instant without being noisy (default is 4000ms).
vim.opt.updatetime = 1000

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = group,
  callback = function()
    -- Don't run while typing a command or in the command-line window.
    if vim.fn.mode() ~= "c" and vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})

-- Notify when a buffer was reloaded out from under us, so it's never a surprise.
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = group,
  callback = function()
    vim.notify("Buffer reloaded (changed on disk)", vim.log.levels.WARN)
  end,
})
