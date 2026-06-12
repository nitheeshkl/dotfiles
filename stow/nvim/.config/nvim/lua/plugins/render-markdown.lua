return {
  -- Pretty in-buffer rendering of markdown (headings, bordered tables,
  -- callouts). The buffer stays normal text, so `/` search still works.
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- markdown + markdown_inline parsers
    "nvim-tree/nvim-web-devicons",
  },
  ft = { "markdown" },
  keys = {
    { "<leader>tm", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle markdown rendering" },
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    -- Keep it rendered even in read-only views; reveal raw source only on the
    -- cursor's line so editing/inspection still works.
    anti_conceal = { enabled = true },
    code = { style = "normal", width = "block", min_width = 40 },
    heading = { sign = false },
  },
}
