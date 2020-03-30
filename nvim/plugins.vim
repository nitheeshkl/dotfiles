" Plugins configurations

call plug#begin('plugins')

" Nerdtree
Plug 'preservim/nerdtree'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git
Plug 'tpope/vim-fugitive'
Plug 'sodapopcan/vim-twiggy'
Plug 'junegunn/gv.vim'

call plug#end()

source nerdtree.vim
source airline.vim
source fugitive.vim
