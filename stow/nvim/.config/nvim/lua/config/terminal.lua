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

-- One persistent shell, two views (same physical key, plain vs shifted):
--   <leader>`  toggle it in a bottom-most, full-width split
--   <leader>~  toggle it in a centered floating window
-- Hiding a view keeps the process (and scrollback) alive; the next toggle
-- brings the same session back, and a fresh shell is only started if the old
-- one exited. Pressing the key for one view while the shell is open in the
-- other MOVES it there (e.g. <leader>~ on the bottom split pops it into the
-- float), so the two keys never fight.
local shell = { buf = nil }

local function shell_win()
  if not (shell.buf and vim.api.nvim_buf_is_valid(shell.buf)) then
    return nil
  end
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == shell.buf then
      return win
    end
  end
end

local function toggle_shell(want_float)
  local win = shell_win()
  if win then
    local was_float = vim.api.nvim_win_get_config(win).relative ~= ""
    vim.api.nvim_win_hide(win)
    if was_float == want_float then
      return -- plain toggle off; otherwise fall through and reopen restyled
    end
  end
  local fresh = not (shell.buf and vim.api.nvim_buf_is_valid(shell.buf))
  if fresh then
    shell.buf = vim.api.nvim_create_buf(false, false)
  end
  if want_float then
    local width = math.floor(vim.o.columns * 0.85)
    local height = math.floor(vim.o.lines * 0.8)
    vim.api.nvim_open_win(shell.buf, true, {
      relative = "editor",
      width = width,
      height = height,
      col = math.floor((vim.o.columns - width) / 2),
      row = math.floor((vim.o.lines - height) / 2) - 1,
      style = "minimal",
      border = "rounded",
      title = " terminal ",
      title_pos = "center",
    })
  else
    -- botright split = bottom-most, spanning the full width.
    vim.cmd("botright " .. math.floor(vim.o.lines * 0.3) .. "split")
    vim.api.nvim_win_set_buf(0, shell.buf)
  end
  if fresh then
    vim.fn.jobstart(vim.o.shell, { term = true })
    -- Survive being hidden; without this the buffer (and shell) dies when
    -- the window closes.
    vim.bo[shell.buf].bufhidden = "hide"
  end
  vim.cmd("startinsert")
end

vim.keymap.set("n", "<leader>`", function()
  toggle_shell(false)
end, { desc = "Toggle bottom terminal" })
vim.keymap.set("n", "<leader>~", function()
  toggle_shell(true)
end, { desc = "Toggle floating terminal" })

-- Auto-hide the FLOAT view when focus leaves it (moving to another window
-- dismisses it, like a popup; the shell keeps running and <leader>~ brings it
-- back). Only the float — the bottom-split view stays put when you hop out.
-- The hide is scheduled because closing the window from inside its own
-- WinLeave is not allowed.
vim.api.nvim_create_autocmd("WinLeave", {
  group = vim.api.nvim_create_augroup("terminal_float_autohide", { clear = true }),
  callback = function()
    local win = vim.api.nvim_get_current_win()
    if
      shell.buf
      and vim.api.nvim_win_get_buf(win) == shell.buf
      and vim.api.nvim_win_get_config(win).relative ~= ""
    then
      vim.schedule(function()
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_hide(win)
        end
      end)
    end
  end,
})
