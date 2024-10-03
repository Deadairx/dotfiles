return {
	{
		"github/copilot.vim",
		config = function()
			vim.keymap.set("n", "<leader>cpd", ":Copilot disable<CR>", { desc = "[C]o[P]ilot [D]isable" })
			vim.keymap.set("n", "<leader>cpe", ":Copilot enable<CR>", { desc = "[C]o[P]ilot [E]nable" })
		end,
	},
}
