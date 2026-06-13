# ⌨️  Neovim Keybindings

> [!NOTE]
> **Leader** = `<Space>`  ·  **Local leader** = `\`
> `C-` = Ctrl  ·  `C-S-` = Ctrl+Shift  ·  `M-` = Alt
> Search this list with `/word`, or fuzzy-search the buffer with
> `:Telescope current_buffer_fuzzy_find`.

> [!WARNING]
> This setup runs under **zellij**, which captures many `Ctrl`+letter chords
> (`g p t n h o b s q`) and `Alt`. See [Notes & zellij caveats](#-notes--zellij-caveats).

---

## 🧭  General

| Key | Action |
|-----|--------|
| `<leader>?` | Show this keybindings reference (read-only split) |
| `<leader><Space>` | Clear search highlight |
| `<leader>o` | Jumplist: back / older location |
| `<leader>i` | Jumplist: forward / newer location |
| `<leader>y` | _(visual)_ Yank selection to system clipboard |

## 🪟  Windows & Splits

| Key | Action |
|-----|--------|
| `<leader>s` | Horizontal split |
| `<leader>v` | Vertical split |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | Move to split left / down / up / right _(tmux-aware)_ |
| `<C-\>` | Move to previous split / pane |
| `<leader><Left>` `<Down>` `<Up>` `<Right>` | Move to window left / down / up / right |

## 🗂️  Tabs

| Key | Action |
|-----|--------|
| `<C-Left>` | Previous tab |
| `<C-Right>` | Next tab |
| `<C-Up>` | First tab |
| `<C-Down>` | Last tab |

---

## 🧠  LSP

_Buffer-local — active in Python, Rust, Lua, … buffers._

| Key | Mode | Action |
|-----|------|--------|
| `gd` | n | Go to definition |
| `gD` | n | Go to declaration |
| `gr` | n | Find references |
| `gi` | n | Go to implementation |
| `<leader>D` | n | Go to type definition |
| `K` | n | Hover documentation |
| `<C-s>` | n · i | Signature help |
| `<leader>rn` | n | Rename symbol |
| `<leader>ca` | n · v | Code action |

## 🩺  Diagnostics

| Key | Action |
|-----|--------|
| `<leader>e` | Show diagnostics for current line |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

## 🎨  Formatting

| Key | Mode | Action |
|-----|------|--------|
| `<leader>gf` | n · v | Format buffer / selection |

> [!TIP]
> Formatting also runs automatically on save (conform.nvim).

## 💬  Commenting · _built-in_

_Neovim's built-in commenting (0.10+). Comment string is filetype-aware (treesitter)._

| Key | Mode | Action |
|-----|------|--------|
| `gcc` | n | Toggle comment on current line |
| `gc` | v | Toggle comment on selection _(`V` to select lines first)_ |
| `gc` + motion | n | Toggle over a motion — e.g. `gc3j`, `gcap`, `gcG` |
| `gbc` | n | Toggle block comment on current line |
| `gb` | v | Toggle block comment on selection |

## ✍️  Prose / Grammar · _harper-ls_

_Active in `markdown`, `text`, `gitcommit` buffers._

| Key / Command | Action |
|---------------|--------|
| `<leader>th` | Toggle grammar/spell hints (current buffer) |
| `:HarperToggle` | Same, as a command |

> [!NOTE]
> Grammar hints are **off by default** and start hidden — flip them on per buffer when you want a pass.

## 📄  Markdown rendering · _render-markdown_

_Active in `markdown` buffers (auto-rendered on open)._

| Key / Command | Action |
|---------------|--------|
| `<leader>tm` | Toggle in-buffer rendering |
| `:RenderMarkdown toggle` | Same, as a command |

> [!TIP]
> The buffer stays normal text while rendered (so `/` search still works); toggle off to drop the whole buffer to raw source.

---

## ✨  Completion · _Insert mode_

_blink.cmp, default preset._

| Key | Action |
|-----|--------|
| `<C-Space>` | Open menu / toggle docs |
| `<Down>` / `<Up>` | Select next / previous _(zellij-safe)_ |
| `<C-n>` / `<C-p>` | Select next / previous |
| `<C-y>` | Accept item |
| `<C-e>` | Hide menu |
| `<C-b>` / `<C-f>` | Scroll docs up / down |
| `<Tab>` / `<S-Tab>` | Jump to next / previous snippet field |

> [!WARNING]
> zellij may eat `<C-n>` `<C-p>` `<C-b>` — use **arrow keys** to select instead.

---

## 🔭  Telescope

**Launch a picker** _(normal mode)_

| Key | Action |
|-----|--------|
| `<leader>f` | Find files _(current file's dir)_ |
| `<C-S-f>` | Live grep _(current file's dir)_ |
| `<leader>b` | List open buffers |

**Inside a picker**

| Key | Action |
|-----|--------|
| `<CR>` | Open in current window |
| `<C-v>` | Open in vertical split |
| `<C-x>` | Open in horizontal split |
| `<C-S-t>` | Open in new tab |
| `<C-Up>` / `<C-Down>` | Scroll preview up / down |
| `<C-Left>` / `<C-Right>` | Scroll preview left / right |

---

## 🌿  Git · _gitsigns_ (inline hunks)

| Key | Mode | Action |
|-----|------|--------|
| `]c` | n | Next hunk |
| `[c` | n | Previous hunk |
| `<leader>hs` | n · v | Stage hunk / selection |
| `<leader>hr` | n · v | Reset hunk / selection |
| `<leader>hp` | n | Preview hunk |
| `<leader>hb` | n | Blame current line |
| `<leader>tb` | n | Toggle inline blame |

---

## 🔀  Git · _fugitive_ (commands)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>gs` | n | Status / staging window |
| `<leader>gc` | n | Commit |
| `<leader>gb` | n | Blame (full file) |
| `<leader>gp` | n | Push |
| `<leader>gP` | n | Pull |

> [!TIP]
> In the `<leader>gs` status window: `s` / `u` stage / unstage, `cc` commit, `=` toggle inline diff, `dv` open a file in a diff-split, `P` push.

---

## 🪟  Git · _diffview_ (diffs & merges)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>gd` | n | Open working-tree diff |
| `<leader>gD` | n | Close diffview |
| `<leader>gh` | n | Current file history |
| `<leader>gH` | n | Repo history |

> [!TIP]
> `:DiffviewOpen main` diffs against any ref/range (e.g. `main...HEAD`). During a merge, `<leader>gd` opens the 3-way conflict view — inside it: `<leader>co` / `ct` / `cb` / `ca` choose **o**urs / **t**heirs / **b**ase / **a**ll, `[x` / `]x` jump between conflicts, `dx` delete a conflict region.

---

## 🌳  File Explorer · _neo-tree_

**Launch**

| Key | Action |
|-----|--------|
| `<leader>n` | Toggle neo-tree & reveal current file |

**Inside the tree** _(press `?` for the full list)_

| Key | Action |
|-----|--------|
| `<CR>` | Open file |
| `<Space>` | Toggle expand / collapse |
| `S` / `s` | Open in horizontal / vertical split |
| `t` | Open in new tab |
| `w` | Open with window picker |
| `P` / `l` | Toggle floating preview / focus preview |
| `C` / `z` | Close node / close all nodes |
| `a` / `A` | Add file / directory |
| `r` / `b` | Rename / rename basename |
| `d` | Delete |
| `y` / `x` / `p` | Copy / cut / paste |
| `c` / `m` | Copy to… / move to… |
| `H` | Toggle hidden files |
| `/` | Fuzzy finder |
| `<BS>` / `.` | Navigate up / set as root |
| `[g` / `]g` | Previous / next git-modified file |
| `<` / `>` | Previous / next source |
| `R` / `q` / `?` | Refresh / close / help |

---

## 📁  File Manager · _yazi_

| Key | Action |
|-----|--------|
| `<leader>-` | Open yazi at the current file |
| `<leader>cw` | Open yazi in working directory |
| `<C-Up>` | Resume last yazi session |

---

## 🦀  Rust · _rustaceanvim_

_Rust buffers use all the **LSP** & **Diagnostics** maps above. Extras via commands:_

| Command | Action |
|---------|--------|
| `:RustLsp codeAction` | Grouped Rust code actions |
| `:RustLsp runnables` | Run targets (tests, main, …) |
| `:RustLsp expandMacro` | Expand macro under cursor |
| `:RustLsp openCargo` | Open `Cargo.toml` |

---

## ⚠️  Notes & zellij caveats

> [!NOTE]
> - **`<C-h/j/k/l>` overlap** — also mapped to `<C-W>` window moves, but
>   vim-tmux-navigator wins (seamless across nvim splits *and* zellij panes).
> - **`<C-Up>` overlap** — bound to *first tab* globally and *resume yazi*; the
>   yazi binding (lazy-loaded) generally wins.
> - **Telescope arrows** — inside a picker, `<C-Up/Down/Left/Right>` scroll the
>   preview, so they don't switch tabs while a picker is open.
> - **zellij-captured chords** — that's why jumplist is on `<leader>o`/`<leader>i`
>   and new-tab is `<C-S-t>`. `Ctrl-Shift` chords need a terminal with the Kitty
>   keyboard protocol (kitty, foot, ghostty, recent wezterm).
