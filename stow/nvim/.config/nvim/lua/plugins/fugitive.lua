return {
  -- The classic full git command surface. Companion to gitsigns: gitsigns
  -- owns inline hunks (<leader>h*), fugitive owns everything else -- the
  -- status/staging window, commits, blame, log, push/pull. Pure vimscript,
  -- no deps, lazy-loaded on its commands so it costs nothing at startup.
  "tpope/vim-fugitive",
  cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Gedit", "Gblame" },
  keys = {
    -- :Git opens the status window -- from there: `s`/`u` stage/unstage,
    -- `cc` commit, `P` push, `=` toggle inline diff, `dv` diff-split a file.
    { "<leader>gs", "<cmd>Git<cr>", desc = "Git status (staging window)" },
    { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
    { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame (full file)" },
    { "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
    { "<leader>gP", "<cmd>Git pull<cr>", desc = "Git pull" },
  },
}
