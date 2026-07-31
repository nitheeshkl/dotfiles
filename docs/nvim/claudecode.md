# Claude Code in Neovim · _claudecode.nvim_

[claudecode.nvim](https://github.com/coder/claudecode.nvim) runs the `claude`
CLI in a terminal split and wires it to nvim over the IDE protocol — the same
one the VS Code extension uses. Claude automatically sees which file is open
and what is selected, and its proposed edits appear as native diffs inside
nvim.

Defined in [`lua/plugins/claudecode.lua`](../../stow/nvim/.config/nvim/lua/plugins/claudecode.lua);
the terminal-escape key lives in
[`lua/config/terminal.lua`](../../stow/nvim/.config/nvim/lua/config/terminal.lua).

## Requirements

- The [`claude` CLI](https://claude.com/claude-code) on `PATH`.
- Nothing else — the plugin is lazy-loaded (zero startup cost until first use)
  and uses nvim's built-in terminal, so there is no snacks.nvim dependency.

## Keybindings

All plugin maps live under the `<leader>a` prefix (leader = `<Space>`).

### Session management _(normal mode, anywhere)_

| Key | Action |
|-----|--------|
| `<leader>ac` | Toggle the Claude terminal (right-hand vsplit; starts `claude` on first use) |
| `<leader>af` | Focus the Claude terminal (jump in, ready to type) |
| `<leader>ar` | `claude --resume` — pick a past session to reopen |
| `<leader>aC` | `claude --continue` — jump straight into the most recent session |
| `<leader>am` | Select the Claude model |

### Sharing context with Claude

| Key | Mode | Action |
|-----|------|--------|
| `<leader>ab` | n | Add the current buffer's file to Claude's context |
| `<leader>as` | v | Send the selected lines to Claude (file + line range) |
| `<leader>as` | n _(neo-tree)_ | Add the file under the cursor to Claude's context |

### Reviewing Claude's edits

When Claude proposes a change it opens as a diff view:

| Key | Action |
|-----|--------|
| `<leader>aa` | Accept the proposed diff |
| `<leader>ad` | Deny / reject it |

### Leaving the terminal

| Key | Mode | Action |
|-----|------|--------|
| `<C-\>` | t _(any terminal)_ | Drop to normal mode |

The stock escape `<C-\><C-n>` doesn't work under zellij (it captures `<C-n>`),
so `<C-\>` alone does it — in the Claude terminal and any other `:terminal`.
From normal mode the usual navigation applies: `<C-h/j/k/l>` between splits,
`<leader><leader>` for the alternate buffer.

## Typical workflow

1. `<leader>ac` — open Claude. It already knows your current file and
   selection via the IDE protocol; no need to paste paths.
2. Add context if useful: visually select code and `<leader>as`, or
   `<leader>ab` for whole files. Type your request in the prompt.
3. When Claude edits a file, review the diff: `<leader>aa` accept,
   `<leader>ad` reject. Files changed on disk are picked up by the
   autoreload config.
4. `<C-\>` then `<C-h>` to get back to your code while Claude works;
   `<leader>af` to hop back into the conversation.
5. Later: `<leader>aC` continues where you left off, `<leader>ar` chooses
   among older sessions.

## Notes

- The `<leader>a*` prefix was chosen because it was entirely unused by the
  rest of the config — no conflicts with existing maps.
- The terminal provider is set to `native` (nvim's own `:terminal`) instead of
  the README-suggested snacks.nvim, to avoid pulling in a large multi-purpose
  plugin for one feature. Switch `terminal.provider` in the plugin spec if the
  floating snacks terminal is ever wanted.
- Don't bind Space-prefixed maps in terminal mode: leader is `<Space>`, and a
  pending mapping would delay every space typed into Claude's prompt.
