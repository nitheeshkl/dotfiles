return {
  -- Claude Code integration: opens the `claude` CLI in a split and wires it to
  -- nvim over the IDE protocol (same one the VS Code extension uses), so Claude
  -- sees your current file/selection and proposes edits as native diffs.
  -- Lazy-loaded on its commands/keys, so no startup cost.
  "coder/claudecode.nvim",
  cmd = {
    "ClaudeCode",
    "ClaudeCodeFocus",
    "ClaudeCodeSelectModel",
    "ClaudeCodeAdd",
    "ClaudeCodeSend",
    "ClaudeCodeTreeAdd",
    "ClaudeCodeStatus",
    "ClaudeCodeStart",
    "ClaudeCodeStop",
    "ClaudeCodeOpen",
    "ClaudeCodeClose",
    "ClaudeCodeDiffAccept",
    "ClaudeCodeDiffDeny",
    "ClaudeCodeCloseAllDiffs",
  },
  keys = {
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Claude: toggle terminal" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Claude: focus terminal" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Claude: resume a session" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Claude: continue last session" },
    { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Claude: select model" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Claude: add current buffer to context" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Claude: send selection" },
    -- In the neo-tree window, sends the file under the cursor instead.
    { "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>", ft = { "neo-tree" }, desc = "Claude: add file from tree" },
    -- Diff review (active while Claude proposes an edit).
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Claude: accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Claude: deny diff" },
  },
  opts = {
    terminal = {
      -- Built-in terminal split; avoids pulling in snacks.nvim just for this.
      provider = "native",
    },
  },
  -- <C-\> drops the Claude terminal (or any :terminal) to normal mode;
  -- that mapping lives in config/terminal.lua.
}
