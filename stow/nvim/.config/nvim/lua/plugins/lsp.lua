-- LSP servers enabled via mason-lspconfig's automatic_enable.
-- NOTE: rust-analyzer is intentionally NOT here; the system one
-- (~/.cargo/bin) is used via rustaceanvim (see rust.lua).
local servers = {
  "lua_ls",
  "pyright",
  "ruff",
  "harper_ls",
  "jsonls",
  "taplo", -- TOML
  "html",
  "dockerls",
  "docker_compose_language_service",
  "bashls", -- bash / sh (uses shellcheck for diagnostics when present)
}

-- nvim-lspconfig ships grouped (nested) root_markers, e.g.
--   { { ".luarc.json", ".luarc.jsonc" }, { ".git" } }
-- which some Neovim nightlies' vim.fs.root cannot handle (it tries to
-- joinpath a table and errors). Flatten to a plain string list so root
-- detection works regardless of the running Neovim version.
local function flatten_root_markers(name)
  local cfg = vim.lsp.config[name]
  if not (cfg and cfg.root_markers) then
    return
  end
  local flat, needs_flatten = {}, false
  for _, m in ipairs(cfg.root_markers) do
    if type(m) == "table" then
      needs_flatten = true
      for _, inner in ipairs(m) do
        flat[#flat + 1] = inner
      end
    else
      flat[#flat + 1] = m
    end
  end
  if needs_flatten then
    vim.lsp.config(name, { root_markers = flat })
  end
end

-- Toggle harper-ls grammar/spell hints for a buffer. harper runs quietly and
-- its diagnostics start hidden; this flips just harper's namespace on/off.
local function toggle_harper(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local client = vim.lsp.get_clients({ bufnr = bufnr, name = "harper_ls" })[1]
  if not client then
    vim.notify("harper-ls is not attached to this buffer", vim.log.levels.WARN)
    return
  end
  local ns = vim.lsp.diagnostic.get_namespace(client.id)
  local on = not vim.diagnostic.is_enabled({ bufnr = bufnr, ns_id = ns })
  vim.diagnostic.enable(on, { bufnr = bufnr, ns_id = ns })
  vim.notify("harper grammar hints: " .. (on and "ON" or "OFF"))
end

return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    -- Depend on nvim-lspconfig so its vim.lsp.config(...) registrations run
    -- BEFORE automatic_enable enables the servers (otherwise servers would be
    -- enabled with default config and skip e.g. pyright's venv on_init).
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        -- mason-lspconfig v2 auto-enables every installed server that has a
        -- vim.lsp.config. Exclude:
        --   rust_analyzer - owned by rustaceanvim (rust.lua); else 2 rust clients.
        --   stylua        - we install the stylua binary for conform formatting,
        --                   but nvim-lspconfig also ships a stylua LSP config, so
        --                   it would otherwise start a redundant `stylua --lsp`.
        --   ltex          - ltex-ls writes WARN lines to stdout, corrupting the
        --                   LSP JSON-RPC stream; excluded even if still installed.
        automatic_enable = { exclude = { "rust_analyzer", "stylua", "ltex" } },
        ensure_installed = servers,
      })
    end,
  },
  {
    -- Reproducibly install non-LSP tools (formatters/linters) so they exist
    -- in mason's PATH on remote machines for conform/ruff to find.
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "stylua", -- Lua formatter
          "ruff", -- Python linter + formatter
          "shfmt", -- bash / sh formatter
          "beautysh", -- zsh formatter (shfmt can't parse zsh)
          "shellcheck", -- shell diagnostics (bashls picks this up)
          "prettier", -- json / yaml / markdown / html formatter
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function()
      -- Apply blink.cmp completion capabilities to every server.
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      -- Python: point pyright at the project's uv-created .venv when present.
      -- Done in on_init (not before_init) so we mutate the live client.settings
      -- that answers pyright's workspace/configuration requests, then notify it.
      vim.lsp.config("pyright", {
        root_markers = { "pyproject.toml", "uv.lock", "setup.py", "setup.cfg", ".git" },
        on_init = function(client)
          local root = client.config.root_dir
          local py = root and (root .. "/.venv/bin/python")
          if py and vim.uv.fs_stat(py) then
            client.settings = vim.tbl_deep_extend("force", client.settings or {}, {
              python = { pythonPath = py },
            })
            client:notify("workspace/didChangeConfiguration", { settings = client.settings })
          end
        end,
      })

      -- Ruff handles linting + code actions; let pyright own hover.
      vim.lsp.config("ruff", {
        on_attach = function(client, _)
          client.server_capabilities.hoverProvider = false
        end,
      })

      -- harper-ls: fast, dependency-free grammar/spell checker for prose
      -- (replaces the removed, misbehaving ltex). Scoped to prose filetypes,
      -- noisy stylistic linters disabled, shown as quiet hints, and OFF by
      -- default -- reveal a grammar pass per buffer with <leader>th /
      -- :HarperToggle.
      vim.lsp.config("harper_ls", {
        filetypes = { "markdown", "text", "gitcommit" },
        settings = {
          ["harper-ls"] = {
            diagnosticSeverity = "hint",
            linters = {
              LongSentences = false,
              SentenceCapitalization = false,
              SpelledNumbers = false,
            },
          },
        },
        on_attach = function(client, bufnr)
          -- start hidden: disable only harper's diagnostic namespace here
          local ns = vim.lsp.diagnostic.get_namespace(client.id)
          vim.diagnostic.enable(false, { bufnr = bufnr, ns_id = ns })
          vim.keymap.set("n", "<leader>th", function() toggle_harper(bufnr) end,
            { buffer = bufnr, desc = "Toggle harper grammar hints" })
        end,
      })

      vim.api.nvim_create_user_command("HarperToggle", function() toggle_harper() end,
        { desc = "Toggle harper grammar/spell hints for the current buffer" })

      -- Flatten grouped root_markers for every enabled server (see note above).
      for _, name in ipairs(servers) do
        flatten_root_markers(name)
      end

      -- Servers are enabled by mason-lspconfig's automatic_enable (after the
      -- binary is installed); the vim.lsp.config blocks above just customize
      -- them. rust-analyzer is owned by rustaceanvim (excluded from auto-enable).

      -- Buffer-local LSP keymaps, set when a server attaches. Also applies to
      -- rust-analyzer (rustaceanvim) since this is a global LspAttach autocmd.
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
        callback = function(ev)
          local builtin = require("telescope.builtin")
          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
          end

          map("n", "gd", builtin.lsp_definitions, "Goto definition")
          map("n", "gD", vim.lsp.buf.declaration, "Goto declaration")
          map("n", "gr", builtin.lsp_references, "Goto references")
          map("n", "gi", builtin.lsp_implementations, "Goto implementation")
          map("n", "<leader>D", builtin.lsp_type_definitions, "Type definition")
          map("n", "K", vim.lsp.buf.hover, "Hover")
          map({ "n", "i" }, "<C-s>", vim.lsp.buf.signature_help, "Signature help")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("n", "<leader>e", vim.diagnostic.open_float, "Line diagnostics")
          map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev diagnostic")
          map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")
        end,
      })

      -- Diagnostics presentation.
      vim.diagnostic.config({
        virtual_text = true,
        severity_sort = true,
        float = { border = "rounded", source = true },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = "󰌵",
          },
        },
      })
    end,
  },
}
