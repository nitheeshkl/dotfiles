return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  opts = {},
  config = function()
    -- dimmed rainbow: onedark syntax hues blended 50% toward the bg (#282c34).
    -- used only for the guide of the scope under the cursor; all other guides
    -- stay in a single muted gray
    local scope_highlight = {
      "DimRed",
      "DimYellow",
      "DimBlue",
      "DimOrange",
      "DimGreen",
      "DimViolet",
      "DimCyan",
    }

    local hooks = require("ibl.hooks")
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "IndentGuide", { fg = "#3B4048" })

      vim.api.nvim_set_hl(0, "DimRed", { fg = "#844C54" })
      vim.api.nvim_set_hl(0, "DimYellow", { fg = "#867657" })
      vim.api.nvim_set_hl(0, "DimBlue", { fg = "#446D91" })
      vim.api.nvim_set_hl(0, "DimOrange", { fg = "#7C634D" })
      vim.api.nvim_set_hl(0, "DimGreen", { fg = "#607756" })
      vim.api.nvim_set_hl(0, "DimViolet", { fg = "#775288" })
      vim.api.nvim_set_hl(0, "DimCyan", { fg = "#3F717B" })
    end)

    -- pick the scope color by the scope's indent level, so the highlighted
    -- guide cycles through the dimmed rainbow like a per-level palette
    -- (ibl's default always uses the first entry of scope.highlight)
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, function(_, bufnr, scope)
      -- use the indentation of the scope's first line, not scope:start()'s
      -- column: in brace languages the block node starts at the `{` at the
      -- end of the line, which is far right of the guide
      local row = scope:start()
      local line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1] or ""
      local indent = #(line:match("^%s*"))
      local sw = vim.bo[bufnr].shiftwidth
      if sw <= 0 then
        sw = vim.bo[bufnr].tabstop
      end
      return (math.floor(indent / sw) % #scope_highlight) + 1
    end)

    -- nvim 0.12 nightly parses treesitter asynchronously, so the tree is
    -- often not (fully) parsed when ibl computes the scope, and
    -- named_node_for_range() returns nil — the scope guide never shows.
    -- Force a sync parse first; it's incremental, so cheap after the
    -- first call. Remove once ibl handles async parsing upstream.
    local scope = require("ibl.scope")
    local scope_get = scope.get
    scope.get = function(bufnr, config)
      local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
      if ok and parser and not parser:is_valid() then
        pcall(parser.parse, parser, true)
      end
      return scope_get(bufnr, config)
    end

    require("ibl").setup({
      -- │ (box-drawing light vertical) renders as a hairline — thinner than
      -- the block glyphs (default ▎ quarter-block, ▏ eighth-block)
      indent = { char = "│", highlight = "IndentGuide" },
      scope = {
        char = "│",
        highlight = scope_highlight,
        -- no underline on the scope's first/last lines; only the guide lights up
        show_start = false,
        show_end = false,
        -- by default ibl's "scope" is the semantic scope (only functions in
        -- python/rust), which colors the far-left guide instead of the block
        -- under the cursor. treat every node as a scope so the innermost
        -- block's guide is the one that lights up
        include = { node_type = { ["*"] = { "*" } } },
      },
    })
  end,
}
