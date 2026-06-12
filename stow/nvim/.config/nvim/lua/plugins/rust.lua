return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  lazy = false, -- this plugin is already lazy via ft handling internally
  ft = { "rust" },
  config = function()
    vim.g.rustaceanvim = {
      -- LSP configuration handed to rust-analyzer (system one from ~/.cargo/bin).
      server = {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
        default_settings = {
          ["rust-analyzer"] = {
            -- Run clippy instead of plain check on save.
            checkOnSave = true,
            check = { command = "clippy" },
            inlayHints = {
              bindingModeHints = { enable = false },
              closureReturnTypeHints = { enable = "never" },
              lifetimeElisionHints = { enable = "never" },
            },
          },
        },
      },
    }
    -- Buffer-local LSP keymaps come from the global LspAttach autocmd in lsp.lua.
  end,
}
