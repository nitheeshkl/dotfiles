return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  config = function()
    -- Compatibility shim: conform calls vim.text.diff on nvim-0.12, but early
    -- 0.12 nightlies report as 0.12 while predating vim.text.diff (they still
    -- have the older, signature-compatible vim.diff). Alias it so formatting
    -- works. No-op on builds where vim.text.diff already exists.
    if not (vim.text and vim.text.diff) and vim.diff then
      vim.text = vim.text or {}
      vim.text.diff = vim.diff
    end

    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        python = { "ruff_format" },
        rust = { "rustfmt" },
        lua = { "stylua" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        html = { "prettier" },
        toml = { "taplo" }, -- same binary as the taplo LSP
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "beautysh" }, -- shfmt can't parse zsh syntax
      },
      -- Only apply formatters that are actually installed (prettier is
      -- best-effort), and fall back to the LSP formatter otherwise.
      default_format_opts = {
        lsp_format = "fallback",
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    })

    -- Manual format (matches existing muscle memory from the old none-ls map).
    vim.keymap.set({ "n", "v" }, "<leader>gf", function()
      conform.format({ async = true, lsp_format = "fallback" })
    end, { desc = "Format buffer/selection" })
  end,
}
