return {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end,
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = {
        "bash",
        "c",
        "csv",
        "cmake",
        "cpp",
        "css",
        "diff",
        "dockerfile",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "html",
        "json",
        "javascript",
        "lua",
        "luadoc",
        "make",
        "markdown",
        "markdown_inline",
        "proto",
        "python",
        "rust",
        "scss",
        "ssh_config",
        "tmux",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",

        -- "bibtex", "latex",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
