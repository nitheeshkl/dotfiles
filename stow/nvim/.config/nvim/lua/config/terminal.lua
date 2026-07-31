-- Terminal-mode escape key.
--
-- <C-\> in ANY :terminal drops to normal mode — a one-key replacement for the
-- stock <C-\><C-n>, which is unusable under zellij (it captures <C-n>).
-- Shadowing the native chord costs nothing since it never worked here anyway.
-- From normal mode the usual window/buffer navigation applies.

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("terminal_escape", { clear = true }),
  callback = function(ev)
    vim.keymap.set("t", "<C-\\>", [[<C-\><C-n>]],
      { buffer = ev.buf, desc = "Terminal: to normal mode" })
  end,
})
