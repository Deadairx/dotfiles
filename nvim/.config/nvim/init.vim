call plug#begin()
Plug 'github/copilot.vim'

" Package Manager
" :MasonUpdate updates registry contents
Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }

" LSP
Plug 'neovim/nvim-lspconfig'
" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" Hide sensative values in Env files
Plug 'laytan/cloak.nvim'

" Aiken
Plug 'aiken-lang/editor-integration-nvim'

Plug 'mbbill/undotree'

" WhichKey
Plug 'folke/which-key.nvim'

" Git Commands
Plug 'tpope/vim-fugitive'
" Git lens
Plug 'APZelos/blamer.nvim'

" Fuzzy Finders
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Themes
Plug 'ayu-theme/ayu-vim'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'NLKNguyen/papercolor-theme'
Plug 'sainnhe/everforest'
Plug 'jdkanani/vim-material-theme'
Plug 'jsit/toast.vim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

" Roam like navigation
Plug 'jakewvincent/mkdnflow.nvim'
call plug#end()

lua require("lsp-config")
lua require("treesitter-config")
lua require("whichkey-config")
lua require("mkdnflow-config")
lua require("cloak-config")

" To help with mkdnflow link following
autocmd FileType markdown set autowriteall

set termguicolors     " enable true colors support
"let ayucolor="dark"   " for dark version of theme
set background=dark
colorscheme gruvbox

nnoremap <leader>cu :colorscheme gruvbox<CR>
nnoremap <leader>ce :colorscheme PaperColor<CR>
nnoremap <leader>co :colorscheme toast<CR>
nnoremap <leader>ca :colorscheme everforest<CR>

nnoremap <leader>cl :set background=light<CR>
nnoremap <leader>cd :set background=dark<CR>

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
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>
nnoremap <leader>bu :Buffers<CR>
nnoremap <leader>cm :norm I//<CR>
nnoremap <leader><leader>x :source %<CR>
nnoremap <leader>cpd :Copilot disable<CR>
nnoremap <leader>cpe :Copilot enable<CR>

"source ~/.config/nvim/coc.vim
