function ColorMyPencils(color)
    vim.cmd("colorscheme " .. color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    --vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils("tokyonight-night") -- Default colorscheme

vim.api.nvim_set_keymap("n", "<leader>cu", "", { callback = ColorMyPencils("gruvbox"), noremap = true, silent = true })

vim.cmd.colorscheme("tokyonight-night")
vim.api.nvim_set_keymap("n", "<leader>cu", ":colorscheme gruvbox<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ce", ":colorscheme PaperColor<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>co", ":colorscheme toast<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ca", ":colorscheme molokai<CR>", { noremap = true, silent = true })

-- light mode
vim.api.nvim_set_keymap("n", "<leader>cl", ":set background=light<CR>", { noremap = true, silent = true })
-- dark mode
vim.api.nvim_set_keymap("n", "<leader>cd", ":set background=dark<CR>", { noremap = true, silent = true })
