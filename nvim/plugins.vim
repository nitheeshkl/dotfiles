" Plugins configurations

call plug#begin('~/.config/nvim/plugins')

" Nerdtree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git
Plug 'tpope/vim-fugitive'
Plug 'sodapopcan/vim-twiggy'
Plug 'junegunn/gv.vim'

" Color themes
Plug 'joshdick/onedark.vim'

" Polyglot for syntax and indentation
Plug 'sheerun/vim-polyglot'

call plug#end()

source ~/.config/nvim/onedark.vim
source ~/.config/nvim/nerdtree.vim
source ~/.config/nvim/airline.vim
source ~/.config/nvim/fugitive.vim
