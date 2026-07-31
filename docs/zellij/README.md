# zellij (`stow/zellij`)

[zellij](https://github.com/zellij-org/zellij) config, the `vesper_kln` theme, the
`default` layout, and the [zjstatus](https://github.com/dj95/zjstatus) status
bar. The package mirrors `~/.config/zellij`:

```
stow/zellij/.config/zellij/config.kdl
stow/zellij/.config/zellij/themes/vesper_kln.kdl
stow/zellij/.config/zellij/layouts/default.kdl
stow/zellij/.config/zellij/plugins/zjstatus.wasm   # committed (see below)
```

## Setup

`zjstatus.wasm` is a compiled binary checked into the repo, so stowing is all
that's needed:

```bash
cd ~/dotfiles/stow

# 1. if a real ~/.config/zellij already exists, move it aside first
#    (stow refuses to overwrite a non-symlink)
mv ~/.config/zellij ~/.config/zellij.bak 2>/dev/null || true

# 2. create the symlink
stow -t ~ zellij    # -> ~/.config/zellij
```

> The committed `zjstatus.wasm` is pinned to whatever release was last vendored.
> To update it, drop a newer build from
> [zjstatus releases](https://github.com/dj95/zjstatus/releases) into
> `stow/zellij/.config/zellij/plugins/zjstatus.wasm` and commit it.

> Adding a *new* zellij config to this repo follows the same shape: copy the
> file into the path it should have under `$HOME` (i.e. under
> `stow/zellij/.config/zellij/…`), then re-run `stow -t ~ zellij`.

## Keybinding notes

The config frees several chords so they reach nvim (see the warning at the top
of [`keybindings.md`](../../stow/nvim/.config/nvim/keybindings.md)):

- `Ctrl-h` is left unbound so `<C-h/j/k/l>` reach nvim for split navigation;
  move-mode lives on `Ctrl-m` instead.
- zellij pane navigation is `Alt-h/j/k/l`.
- zellij still captures many `Ctrl`+letter chords (`g p t n o b s q m`) — nvim
  maps avoid them (e.g. jumplist on `<leader>o`/`<leader>i`, terminal escape
  on `<C-\>`).
