vim.o.termguicolors = true
vim.o.background = 'dark'
vim.cmd('colorscheme gruvbox')

vim.o.cursorline = true
vim.o.colorcolumn = '120'
vim.o.nohlsearch = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.scrolloff = 5
vim.o.sidescrolloff = 5

-- blamer 
vim.g.blamer_enabled = 1
vim.g.blamer_delay = 300

-- leader
vim.g.mapleader = ' '

buf_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })
buf_set_keymap('n', '<leader>pv', ':Ex<CR>', { noremap = true, silent = true })
buf_set_keymap('n', '<leader><CR>', ':so ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })
buf_set_keymap('n', '<leader>ff', ':telescope find_files<CR>', { noremap = true, silent = true })
buf_set_keymap('n', '<leader>pg', ':GFiles<CR>', { noremap = true, silent = true })
buf_set_keymap('n', '<leader>pf', ':Files<CR>', { noremap = true, silent = true })
buf_set_keymap('n', '<C-k>', ':cnext<CR>', { noremap = true, silent = true })
buf_set_keymap('n', '<C-j>', ':cprev<CR>', { noremap = true, silent = true })
buf_set_keymap('n', '<leader>bu', ':Buffers<CR>', { noremap = true, silent = true })
buf_set_keymap('n', '<leader>cm', ':norm I//<CR>', { noremap = true, silent = true })
buf_set_keymap('n', '<leader><leader>x', ':source %<CR>', { noremap = true, silent = true })
buf_set_keymap('n', '<leader>cpd', ':Copilot disable<CR>', { noremap = true, silent = true })
buf_set_keymap('n', '<leader>cpe', ':Copilot enable<CR>', { noremap = true, silent = true })
