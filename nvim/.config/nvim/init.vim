call plug#begin()
Plug 'github/copilot.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Git lens
Plug 'APZelos/blamer.nvim'

" Fuzzy Finders
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Themes
Plug 'ayu-theme/ayu-vim'
Plug 'ellisonleao/gruvbox.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-tree-sitter/nvim-treesitter'
Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
call plug#end()

" lua require("lsp-config")

set termguicolors     " enable true colors support
"let ayucolor="dark"   " for dark version of theme
set background=dark
colorscheme gruvbox

set cursorline
set colorcolumn=120
set nohlsearch
set number
set relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set scrolloff=5

let g:blamer_enabled = 1
let g:blamer_delay = 300

let mapleader = " "

inoremap jk <Esc>
nnoremap <leader>pv :Ex<CR>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <leader>ff :telescope find_files<CR>
nnoremap <leader>pg :GFiles<CR>
nnoremap <leader>pf :Files<CR>
nnoremap <C-k> :cnext<CR>
nnoremap <C-j> :cprev<CR>
nnoremap <leader>bu :Buffers<CR>
nnoremap <leader>cm :norm I//<CR>
nnoremap <leader><leader>x :source %<CR>

source ~/.config/nvim/coc.vim

