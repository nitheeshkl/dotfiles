# dotfiles

Personal dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/).

The actively-maintained configs live under [`stow/`](stow/), one directory
per "package". Each package mirrors the layout it should have under `$HOME`,
so stowing it just creates the right symlinks:

| Package | Symlinks to | What it is | Docs |
|---------|-------------|------------|------|
| `stow/nvim`   | `~/.config/nvim`   | Neovim — lazy.nvim, LSP, completion, git, formatting, Claude Code | [docs/nvim/](docs/nvim/README.md) |
| `stow/kitty`  | `~/.config/kitty`  | kitty terminal config | — |
| `stow/zellij` | `~/.config/zellij` | zellij multiplexer — config, vesper theme, zjstatus bar | [docs/zellij/](docs/zellij/README.md) |
| `stow/herdr`  | `~/.config/herdr/config.toml` | herdr workspace manager — zellij-style keybindings | [docs/herdr/](docs/herdr/README.md) |

> The top-level `vim/`, `nvim/`, and `vimrc` are an **older** vim-plug / coc.nvim
> setup, kept for reference. New work happens in `stow/`.

## Install

On a fresh Debian/Ubuntu machine (amd64 or arm64), [`install.sh`](install.sh)
sets up **nvim + zellij** end to end — apt build deps, rustup, nvm + Node LTS,
the tree-sitter CLI, neovim built from master, zellij and yazi built from
source with cargo — then stows both configs:

```bash
git clone <this-repo> ~/dotfiles
cd ~/dotfiles
./install.sh            # idempotent; --force rebuilds everything
```

Only the apt step uses sudo; everything else lands in `~/.local` /
`~/.cargo/bin`. Existing non-symlink configs are moved to
`~/.config/<name>.pre-stow.bak` before stowing.

To stow packages manually (e.g. kitty, which the script doesn't cover):

```bash
cd ~/dotfiles/stow

stow -t ~ nvim      # -> ~/.config/nvim
stow -t ~ kitty     # -> ~/.config/kitty
stow -t ~ zellij    # -> ~/.config/zellij
stow -t ~ herdr     # -> ~/.config/herdr/config.toml
```

`-t ~` targets your home directory. If a config already exists at the target
path, move it aside first or stow will refuse to overwrite a non-symlink.

To remove a package's symlinks: `stow -t ~ -D nvim`.

## Docs

Per-component guides live under [`docs/`](docs/), one directory per stow
package:

- [`docs/nvim/`](docs/nvim/README.md) — setup, prerequisites, first launch.
  - [`docs/nvim/claudecode.md`](docs/nvim/claudecode.md) — Claude Code
    integration: keybindings and workflow.
  - [`keybindings.md`](stow/nvim/.config/nvim/keybindings.md) — full key
    reference (lives with the config so `<leader>?` can open it in nvim).
- [`docs/zellij/`](docs/zellij/README.md) — setup, zjstatus, keybinding notes.
- [`docs/herdr/`](docs/herdr/README.md) — setup, zellij → herdr keybinding mapping.
