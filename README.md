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

```bash
git clone <this-repo> ~/dotfiles
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
