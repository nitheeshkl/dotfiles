# Neovim (`stow/nvim`)

A lean, fast, IDE-like setup for **Python** and **Rust** on remote dev servers,
built on [lazy.nvim](https://github.com/folke/lazy.nvim). Everything is
lazy-loaded for near-zero startup cost.

Docs for this component:

- [`keybindings.md`](../../stow/nvim/.config/nvim/keybindings.md) — full key
  reference (`<leader>?` opens it inside nvim; kept next to the config so
  it's available at runtime)
- [`claudecode.md`](claudecode.md) — Claude Code integration: keybindings and
  workflow

## Prerequisites

Install these on `PATH` **before** the first launch:

| Tool | Why |
|------|-----|
| **Neovim** (≥ 0.11; 0.12-nightly recommended) | uses the `vim.lsp.config` API |
| **git** | lazy.nvim bootstrap + fugitive / diffview |
| **gcc/clang + make** | nvim-treesitter compiles parsers on install |
| **ripgrep** (`rg`) + **fd** | telescope find / live-grep |
| **node + npm** | mason installs node-based servers (pyright, jsonls, html, bashls) + prettier |
| a **Nerd Font** | icons in neo-tree / lualine / web-devicons |

Language-specific (only what you use):

- **Python** — [`uv`](https://github.com/astral-sh/uv) (or `python3`). A
  project's `uv`-created `.venv` is auto-detected by pyright.
- **Rust** — [`rustup`](https://rustup.rs) with a **system `rust-analyzer`** in
  `~/.cargo/bin`. rustaceanvim drives that binary directly — it is deliberately
  *not* installed via mason.
- **Optional** — [`yazi`](https://github.com/sxyazi/yazi) (file-manager
  integration), `tmux` / `zellij` (seamless pane navigation),
  [`claude` CLI](https://claude.com/claude-code) (Claude Code integration,
  see [claudecode.md](claudecode.md)).

On Debian/Ubuntu, the system packages are roughly:

```bash
sudo apt install neovim git stow build-essential ripgrep fd-find nodejs npm
```

## First launch

```bash
nvim
```

lazy.nvim bootstraps itself and installs all plugins; mason then pulls the LSP
servers and tools (pyright, ruff, lua_ls, taplo, jsonls, html, bashls, dockerls,
harper_ls, plus stylua, shfmt, beautysh, shellcheck, prettier). Give it a minute,
then run `:Lazy sync` and `:Mason` to confirm everything installed.

> **Remote gotcha:** a few mason **LSP** server installs don't always trigger on a
> non-interactive first run. If one is missing, install it directly, e.g.
> `:MasonInstall taplo`.

## Verify

- `:checkhealth` — flags any missing external binary (rg, fd, node, compiler).
- `:Lazy` — all plugins green; `:Mason` — servers/tools installed.
- Open a Python file in a `uv` project → pyright attaches and resolves
  `.venv/bin/python`; open a `.rs` file in a cargo project → rust-analyzer attaches.
- `<leader>?` — open the keybindings reference.
