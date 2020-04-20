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

" Context aware pasting with 'p' and 'P'
Plug 'sickill/vim-pasta'

" additional vim c++ syntax highlighting
Plug 'octol/vim-cpp-enhanced-highlight'

" Code Completion - COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Google code formating
" Add maktaba and codefmt to the runtimepath.
" (The latter must be installed before it can be used.)
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plug 'google/vim-glaive'

call plug#end()

source ~/.config/nvim/onedark.vim
source ~/.config/nvim/nerdtree.vim
source ~/.config/nvim/airline.vim
source ~/.config/nvim/fugitive.vim
source ~/.config/nvim/startify.vim
source ~/.config/nvim/goyo.vim
source ~/.config/nvim/limelight.vim
source ~/.config/nvim/enhanced_cpp.vim
source ~/.config/nvim/coc.vim
source ~/.config/nvim/codefmt.vim
