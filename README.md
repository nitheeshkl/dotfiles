# dotfiles

Personal dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/).

The actively-maintained configs live under [`stow/`](stow/), one directory
per "package". Each package mirrors the layout it should have under `$HOME`,
so stowing it just creates the right symlinks:

| Package | Symlinks to | What it is |
|---------|-------------|------------|
| `stow/nvim`  | `~/.config/nvim`  | Neovim — lazy.nvim, LSP, completion, git, formatting (see below) |
| `stow/kitty` | `~/.config/kitty` | kitty terminal config |

> The top-level `vim/`, `nvim/`, and `vimrc` are an **older** vim-plug / coc.nvim
> setup, kept for reference. New work happens in `stow/`.

## Install

```bash
git clone <this-repo> ~/dotfiles
cd ~/dotfiles/stow

stow -t ~ nvim      # -> ~/.config/nvim
stow -t ~ kitty     # -> ~/.config/kitty
```

`-t ~` targets your home directory. If a config already exists at the target
path, move it aside first or stow will refuse to overwrite a non-symlink.

To remove a package's symlinks: `stow -t ~ -D nvim`.

## Neovim (`stow/nvim`)

A lean, fast, IDE-like setup for **Python** and **Rust** on remote dev servers,
built on [lazy.nvim](https://github.com/folke/lazy.nvim). Everything is
lazy-loaded for near-zero startup cost. See
[`keybindings.md`](stow/nvim/.config/nvim/keybindings.md) for the full key
reference (`<leader>?` opens it inside nvim).

### Prerequisites

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
  integration), `tmux` / `zellij` (seamless pane navigation).

On Debian/Ubuntu, the system packages are roughly:

```bash
sudo apt install neovim git stow build-essential ripgrep fd-find nodejs npm
```

### First launch

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

### Verify

- `:checkhealth` — flags any missing external binary (rg, fd, node, compiler).
- `:Lazy` — all plugins green; `:Mason` — servers/tools installed.
- Open a Python file in a `uv` project → pyright attaches and resolves
  `.venv/bin/python`; open a `.rs` file in a cargo project → rust-analyzer attaches.
- `<leader>?` — open the keybindings reference.
