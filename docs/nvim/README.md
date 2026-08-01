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
| **gcc/clang + make** | C toolchain the parser build shells out to |
| **`tree-sitter` CLI** (≥ 0.26.1) | nvim-treesitter `main` compiles parsers with it (see below) |
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

### tree-sitter CLI

This config pins nvim-treesitter to its **`main`** branch
([`lua/plugins/treesitter.lua`](../../stow/nvim/.config/nvim/lua/plugins/treesitter.lua)).
Unlike the old `master` branch, `main` builds parsers by shelling out to the
`tree-sitter` CLI instead of invoking `cc` itself — so a C compiler alone is
**not** enough. Without the CLI, every launch re-downloads all ~32 parsers,
fails at the compile step, and floods the screen with:

```
[nvim-treesitter/install/lua] error: Error during "tree-sitter build":
  ENOENT: no such file or directory (cmd): 'tree-sitter'
```

Nothing is cached, so it repeats on every start until the CLI is installed.

`apt` is not an option here — its `tree-sitter-cli` candidate is **0.20.8**, far
below the required 0.26.1.

`npm install -g tree-sitter-cli` does work: its postinstall downloads the same
GitHub release asset, and the shipped binary is byte-identical to the one below.
But npm's `.bin/tree-sitter` is a small **Node wrapper** (`cli.js`) that spawns
that binary, so it adds a permanent `node` runtime dependency and extra process
startup per invocation to a program that otherwise needs neither. Fetching the
release binary directly skips the wrapper entirely:

```bash
VER=v0.26.11   # any >= 0.26.1; check github.com/tree-sitter/tree-sitter/releases
mkdir -p ~/.local/bin
curl -sL "https://github.com/tree-sitter/tree-sitter/releases/download/$VER/tree-sitter-linux-x64.gz" \
  | gunzip > ~/.local/bin/tree-sitter
chmod +x ~/.local/bin/tree-sitter
tree-sitter --version    # ensure ~/.local/bin is on PATH
```

Alternatively `cargo install tree-sitter-cli` if you already have rustup — same
result, just a slow from-source build.

> This binary lives outside the repo and isn't managed by stow or apt, so it's
> the one prerequisite a fresh machine silently misses.

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
- `:checkhealth nvim-treesitter` — should report
  `OK tree-sitter-cli 0.26.x`. If it says `tree-sitter-cli not found`, the CLI
  step above was skipped.
- Open a `.lua` / `.py` / `.rs` file → syntax is highlighted and `:InspectTree`
  shows a parse tree. Parsers install asynchronously on first launch, so an
  unfamiliar filetype may need a second open before highlighting kicks in.
- `:Lazy` — all plugins green; `:Mason` — servers/tools installed.
- Open a Python file in a `uv` project → pyright attaches and resolves
  `.venv/bin/python`; open a `.rs` file in a cargo project → rust-analyzer attaches.
- `<leader>?` — open the keybindings reference.
