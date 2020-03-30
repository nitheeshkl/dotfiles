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

" Fancy startup screen
Plug 'mhinz/vim-startify'

" add end, endif, etc. automatically
Plug 'tpope/vim-endwise'

" detect indent style (tabs vs. spaces)
Plug 'tpope/vim-sleuth'

" Distraction free writing
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

call plug#end()

source ~/.config/nvim/onedark.vim
source ~/.config/nvim/nerdtree.vim
source ~/.config/nvim/airline.vim
source ~/.config/nvim/fugitive.vim
source ~/.config/nvim/startify.vim
source ~/.config/nvim/goyo.vim
source ~/.config/nvim/limelight.vim
