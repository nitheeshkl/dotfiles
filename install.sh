#!/usr/bin/env bash
#
# Bootstrap zellij + nvim from this dotfiles repo on a fresh Debian/Ubuntu
# box (amd64 or arm64):
#
#   1. apt build/runtime dependencies        (the only step that needs sudo)
#   2. rustup + stable toolchain             (zellij and yazi are built with cargo)
#   3. nvm + Node LTS                        (mason's node-based LSP servers, prettier)
#   4. tree-sitter CLI                       (GitHub release binary; nvim-treesitter
#                                             `main` shells out to it, apt's is too old)
#   5. neovim, built from master             (config targets the 0.12 line)
#   6. zellij  — cargo install (from source)
#   7. yazi    — cargo install (from source)
#   8. stow the nvim + zellij packages into $HOME
#
# Everything user-installed lands in ~/.local (or ~/.cargo/bin for cargo
# installs); no sudo outside of apt. Idempotent: each step is skipped when
# its tool is already present. `--force` redoes the skippable steps
# (rebuilds neovim from the latest master, reinstalls cargo/release
# binaries).
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_BIN="$HOME/.local/bin"
SRC_DIR="$HOME/.local/src"
CARGO_BIN="$HOME/.cargo/bin"

TREE_SITTER_VERSION="v0.26.11" # any >= 0.26.1 works for nvim-treesitter main
NVM_VERSION="v0.40.3"

FORCE=0
[[ "${1:-}" == "--force" ]] && FORCE=1

log()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
skip() { printf '\033[1;33m ->\033[0m %s (skipped; --force to redo)\n' "$*"; }
die()  { printf '\033[1;31mERROR:\033[0m %s\n' "$*" >&2; exit 1; }

# ---------------------------------------------------------------- arch ----
case "$(uname -m)" in
  x86_64)  TS_ARCH="linux-x64" ;;
  aarch64) TS_ARCH="linux-arm64" ;;
  *) die "unsupported architecture: $(uname -m) (expected x86_64 or aarch64)" ;;
esac

mkdir -p "$LOCAL_BIN" "$SRC_DIR"

# ---------------------------------------------------- 1. apt packages ----
# build-essential/cmake/gettext/ninja-build/unzip/curl: neovim build deps.
# pkg-config/libssl-dev: common cargo build needs. ripgrep/fd-find/file:
# runtime tools for telescope and yazi. git/stow: this repo itself.
APT_PKGS=(git stow build-essential cmake ninja-build gettext unzip curl
  pkg-config libssl-dev ripgrep fd-find file)

install_apt_packages() {
  local missing=()
  for pkg in "${APT_PKGS[@]}"; do
    dpkg -s "$pkg" &>/dev/null || missing+=("$pkg")
  done
  if [[ ${#missing[@]} -eq 0 ]]; then
    log "apt packages already installed"
    return
  fi
  log "installing apt packages: ${missing[*]}"
  sudo apt-get update
  sudo apt-get install -y "${missing[@]}"
}

# Ubuntu/Debian ship fd as `fdfind`; give it its upstream name.
link_fd() {
  if command -v fd &>/dev/null; then return; fi
  if command -v fdfind &>/dev/null; then
    log "symlinking fd -> fdfind in $LOCAL_BIN"
    ln -sf "$(command -v fdfind)" "$LOCAL_BIN/fd"
  fi
}

# --------------------------------------------------------- 2. rustup ----
install_rustup() {
  if [[ -x "$CARGO_BIN/cargo" ]]; then
    log "rust toolchain already installed ($("$CARGO_BIN/cargo" --version))"
  else
    log "installing rustup (stable, minimal profile)"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs |
      sh -s -- -y --default-toolchain stable --profile minimal
  fi
  # Make cargo usable for the rest of this run without a new shell.
  # shellcheck disable=SC1091
  source "$HOME/.cargo/env"
}

# --------------------------------------------------- 3. nvm + node ----
install_node() {
  export NVM_DIR="$HOME/.nvm"
  if [[ ! -s "$NVM_DIR/nvm.sh" ]]; then
    log "installing nvm $NVM_VERSION"
    curl -sSf "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh" | bash
  fi
  # shellcheck disable=SC1091
  source "$NVM_DIR/nvm.sh"
  if command -v node &>/dev/null && [[ $FORCE -eq 0 ]]; then
    skip "node already installed ($(node --version))"
    return
  fi
  log "installing Node LTS via nvm"
  nvm install --lts
  nvm alias default 'lts/*'
}

# ---------------------------------------------- 4. tree-sitter CLI ----
install_tree_sitter() {
  if [[ -x "$LOCAL_BIN/tree-sitter" && $FORCE -eq 0 ]]; then
    skip "tree-sitter already installed ($("$LOCAL_BIN/tree-sitter" --version))"
    return
  fi
  log "installing tree-sitter CLI $TREE_SITTER_VERSION ($TS_ARCH)"
  curl -sSfL "https://github.com/tree-sitter/tree-sitter/releases/download/$TREE_SITTER_VERSION/tree-sitter-$TS_ARCH.gz" |
    gunzip >"$LOCAL_BIN/tree-sitter"
  chmod +x "$LOCAL_BIN/tree-sitter"
}

# ------------------------------------------- 5. neovim from source ----
install_neovim() {
  if [[ -x "$LOCAL_BIN/nvim" && $FORCE -eq 0 ]]; then
    skip "neovim already installed ($("$LOCAL_BIN/nvim" --version | head -1))"
    return
  fi
  local src="$SRC_DIR/neovim"
  if [[ -d "$src/.git" ]]; then
    log "updating neovim source (master)"
    git -C "$src" fetch --depth 1 origin master
    git -C "$src" reset --hard origin/master
  else
    log "cloning neovim (master, shallow)"
    git clone --depth 1 https://github.com/neovim/neovim "$src"
  fi
  log "building neovim (this takes a few minutes)"
  make -C "$src" distclean
  make -C "$src" CMAKE_BUILD_TYPE=RelWithDebInfo "CMAKE_INSTALL_PREFIX=$HOME/.local" install
}

# ------------------------------------------- 6. zellij from source ----
install_zellij() {
  if [[ -x "$CARGO_BIN/zellij" && $FORCE -eq 0 ]]; then
    skip "zellij already installed ($("$CARGO_BIN/zellij" --version))"
    return
  fi
  log "building zellij with cargo (this takes a while)"
  cargo install --locked zellij
}

# --------------------------------------------- 7. yazi from source ----
install_yazi() {
  if [[ -x "$CARGO_BIN/yazi" && $FORCE -eq 0 ]]; then
    skip "yazi already installed ($("$CARGO_BIN/yazi" --version))"
    return
  fi
  log "building yazi with cargo (this takes a while)"
  cargo install --locked yazi-fm yazi-cli
}

# ------------------------------------------------- 8. stow configs ----
STOW_PKGS=(nvim zellij)

stow_configs() {
  for pkg in "${STOW_PKGS[@]}"; do
    local target="$HOME/.config/$pkg"
    if [[ -e "$target" && ! -L "$target" ]]; then
      local backup="$target.pre-stow.bak"
      [[ -e "$backup" ]] && die "both $target and $backup exist; resolve manually"
      log "backing up existing $target -> $backup"
      mv "$target" "$backup"
    fi
  done
  log "stowing: ${STOW_PKGS[*]}"
  stow -d "$REPO_DIR/stow" -t "$HOME" "${STOW_PKGS[@]}"
}

# ------------------------------------------------------ PATH check ----
check_path() {
  local missing=()
  case ":$PATH:" in *":$LOCAL_BIN:"*) ;; *) missing+=("$LOCAL_BIN") ;; esac
  case ":$PATH:" in *":$CARGO_BIN:"*) ;; *) missing+=("$CARGO_BIN") ;; esac
  if [[ ${#missing[@]} -gt 0 ]]; then
    printf '\033[1;33mNOTE:\033[0m add to PATH in your shell rc: %s\n' "${missing[*]}"
  fi
}

install_apt_packages
link_fd
install_rustup
install_node
install_tree_sitter
install_neovim
install_zellij
install_yazi
stow_configs
check_path

log "done. Start nvim once to let lazy.nvim install plugins."
