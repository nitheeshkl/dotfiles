# herdr (`stow/herdr`)

[herdr](https://herdr.dev) — terminal workspace manager for AI coding agents.
The package mirrors `~/.config/herdr`:

```
stow/herdr/.config/herdr/config.toml
```

herdr keeps runtime state (logs, `session.json`, sockets) in the same
directory. On a fresh stow, `~/.config/herdr` becomes a folded symlink to
the package dir, so that runtime state lands inside the repo — the repo
`.gitignore` allowlists `config.toml` and ignores everything else there,
so this is fine. Never `git add -f` anything from that directory.

## Setup (new machine)

```bash
# 1. install herdr (or: brew install herdr / mise use -g herdr)
curl -fsSL https://herdr.dev/install.sh | sh

# 2. stow the config
cd ~/dotfiles/stow
# if herdr already ran and created a real dir, keep only its runtime files:
#   mv ~/.config/herdr/config.toml ~/.config/herdr/config.toml.bak
stow -t ~ herdr     # -> ~/.config/herdr (or just config.toml if dir exists)

herdr config check              # validate
herdr server reload-config      # apply live if a server is running

# 3. (optional) let herdr's agent panel track Claude Code sessions,
#    including ones launched inside nvim (claudecode.nvim) — requires
#    Claude Code installed; adds a SessionStart hook to ~/.claude/settings.json
herdr integration install claude
herdr integration status        # should show: claude: current
```

## Remote systems

`herdr --remote <ssh-target>` connects the local client to a herdr server
on the remote host, offering to install the remote binary on first use.
The server side is what reads `config.toml`, so keybindings, the theme,
and the claude integration must be set up **on the remote**: clone the
dotfiles there and run the same steps above. The only local-side binding
is `remote_image_paste` (`ctrl+v`, herdr default).

## Keybindings

Alt is the primary modifier: frequent actions are direct `alt+key` chords,
the same always-on Alt layer zellij uses. (A bare modifier can't be a herdr
prefix key — herdr rejects `prefix = "alt"` — so this is how "Alt as prefix"
is expressed.) Less-frequent commands sit behind herdr's real prefix, moved
to `alt+a` so everything lives in the Alt namespace. (Rejected: `alt+space`
— KDE grabs it globally for KRunner; `alt+b` — readline backward-word.)

nvim is untouched: `ctrl+h/j/k/l` (window nav) is deliberately never bound.

### Direct Alt layer

| herdr action  | key             | zellij equivalent                    |
|---------------|-----------------|--------------------------------------|
| focus pane    | `alt+hjkl`      | global `Alt+hjkl`                    |
| new pane      | `alt+n`         | global `Alt+n` (side-by-side split)  |
| split down    | `alt+d`         | pane mode `Ctrl+p d` (new pane down) |
| close pane    | `alt+x`         | pane mode `x` / tmux mode `x`        |
| zoom pane     | `alt+z`         | tmux mode `z` / pane mode `f`        |
| new tab       | `alt+c`         | tmux mode `c`                        |
| prev/next tab | `alt+left/right`| global `Alt+←/→`                     |
| go to tab 1–9 | `alt+1..9`      | tab mode `1..9` (now direct)         |
| resize mode   | `alt+r`         | resize mode `Ctrl+n` (moved to Alt)  |
| copy/scroll   | `alt+s`         | scroll mode `Ctrl+s` (moved to Alt)  |

### Remaining on the prefix — `alt+a`, then: (herdr defaults)

| herdr action     | key              |
|------------------|------------------|
| detach           | `prefix+q`       |
| edit scrollback  | `prefix+e`       |
| rename tab       | `prefix+shift+t` |
| rename pane      | `prefix+shift+p` |
| close tab        | `prefix+shift+x` |
| workspace picker | `prefix+w`       |
| new workspace    | `prefix+shift+n` |
| reload config    | `prefix+shift+r` |
| help             | `prefix+?`       |

### Differences to be aware of

- Alt chords bound here (`alt+h/j/k/l/n/d/x/z/c`, `alt+←/→`, `alt+1..9`) are
  swallowed by herdr and never reach pane apps — same as zellij's Alt layer.
  Unbound Alt chords still pass through.
- herdr has no move mode (`Ctrl+m` in zellij) and no floating panes
  (`Alt+f`); pane rearranging is done with the mouse or resize mode.
- Workspaces are herdr-specific: `prefix+w` opens the workspace picker,
  roughly where zellij's session manager (`Ctrl+o w`) lives in muscle memory.
