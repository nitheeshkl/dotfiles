-- Jump to the last cursor position when reopening a file.
--
-- Neovim records the cursor position in the `"` mark when leaving a buffer and
-- persists it across sessions via the shada file; this autocmd jumps to that
-- mark on open. No plugin needed.

vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("RestoreCursor", { clear = true }),
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    -- Don't restore for commit/rebase buffers -- you always want the top there.
    if ft == "gitcommit" or ft == "gitrebase" then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local last_line = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= last_line then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
      vim.cmd("normal! zvzz") -- open any fold around the line and center it
    end
  end,
})
