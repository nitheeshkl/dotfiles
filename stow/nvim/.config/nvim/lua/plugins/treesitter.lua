-- nvim-treesitter `main` branch.
--
-- The `main` branch removed `require("nvim-treesitter.configs").setup()` and the
-- module system (highlight/indent/auto_install options). Instead:
--   * parsers are installed imperatively via `require("nvim-treesitter").install()`
--   * highlighting is started per-buffer with `vim.treesitter.start()`
--   * indentation is opt-in via the `indentexpr()` helper
-- We wire all of that up from a single FileType autocmd below.
local ensure_installed = {
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
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  -- The main branch recommends eager-loading the plugin itself; the FileType
  -- autocmd is what actually defers per-language work.
  lazy = false,
  build = ":TSUpdate",
  config = function()
    -- Install the curated set up front (async, non-blocking).
    require("nvim-treesitter").install(ensure_installed)

    vim.api.nvim_create_autocmd("FileType", {
      desc = "Enable treesitter highlighting + indentation, auto-installing missing parsers",
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
        if not lang then
          return
        end

        -- Replaces the old `auto_install = true`: pull a parser we don't have
        -- yet. install() is async, so highlighting starts on the next open of
        -- this filetype once the parser has landed. `get_lang` falls back to
        -- the filetype itself when unmapped (e.g. "neo-tree"), so we only fetch
        -- langs that actually exist upstream to avoid "unsupported language".
        if not vim.tbl_contains(require("nvim-treesitter").get_installed(), lang) then
          if vim.tbl_contains(require("nvim-treesitter.config").get_available(), lang) then
            require("nvim-treesitter").install({ lang })
          end
          return
        end

        vim.treesitter.start(args.buf, lang)
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
