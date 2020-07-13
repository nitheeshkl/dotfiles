# klnvim
My Vim configurations

# Setup

## Get the repo with submodules

```
git clone https://github.com/nitheeshkl/klnvim.git
cd klnvim
git submodule init
git submodule update
```
## Link vim resources

```
ln -sf <klnvim_path>/vimrc ~/.vimrc
ln -sf <klnvim_path>/vim ~/.vim
```

## Neovim setup

1. Install neovim
2. `ln -sf <klnvim_path>/nvim ~/.config/nvim`
3. Install [vim-plug](https://github.com/junegunn/vim-plug)
    ```
    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vi
    ```
4. Open nvim and run `:PlugUpdate`. This will install all the required plugins in `~/.nvim/plugins`.
5. Install plugin dependencies, like 'node', 'clang', etc.
6. Setup NerdFonts or patch your own font for the NerdTree fonts - [font-patcher](https://github.com/ryanoasis/nerd-fonts#font-patcher). This is required for the symbols and icons used in airline/powerline and nerdtree.
