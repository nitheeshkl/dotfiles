return {
  -- Dedicated diff + merge-conflict UI. Far better than fugitive for reviewing
  -- large diffs (side-by-side file panel) and resolving complex 3-way merge
  -- conflicts. Lazy-loaded on its commands, so no startup cost.
  "sindrets/diffview.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles" },
  keys = {
    -- Working-tree diff. During a merge this opens the 3-way conflict view;
    -- inside it the default conflict maps apply: <leader>co/ct/cb/ca choose
    -- ours/theirs/base/all, [x / ]x jump between conflicts, dx delete region.
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview: open working-tree diff" },
    { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Diffview: close" },
    -- History browsing.
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: current file history" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview: repo history" },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      -- Side-by-side panes for working diffs and history.
      default = { layout = "diff2_horizontal" },
      -- 3-way + base for merges: ours | working | theirs, with the merge-base
      -- in a 4th window, so you can see exactly how each side diverged.
      merge_tool = { layout = "diff3_mixed", disable_diagnostics = true },
    },
  },
}
