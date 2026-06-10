return {
  "saghen/blink.cmp",
  -- Use a release tag so the prebuilt fuzzy-matcher binary is downloaded
  -- (no local Rust build needed -- friendlier on remote machines).
  version = "1.*",
  event = "InsertEnter",
  opts = {
    -- 'default' (recommended) keymap:
    --   <C-space> open/docs, <C-n>/<C-p> or <Up>/<Down> select,
    --   <C-y> accept, <C-e> hide, <Tab>/<S-Tab> snippet jump.
    keymap = { preset = "default" },

    appearance = {
      nerd_font_variant = "mono",
    },

    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      ghost_text = { enabled = true },
    },

    signature = { enabled = true },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    -- Rust fuzzy matcher with Lua fallback if the binary is unavailable.
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
