return {
	{
		-- You can easily change to a different colorscheme.
		-- Change the name of the colorscheme plugin below, and then
		-- change the command in the config to whatever the name of that colorscheme is.
		--
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
		"ayu-theme/ayu-vim",
		"ellisonleao/gruvbox.nvim",
		"altercation/vim-colors-solarized",
		"tomasr/molokai",
		"NLKNguyen/papercolor-theme",
		"sainnhe/everforest",
		"jdkanani/vim-material-theme",
		"jsit/toast.vim",
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			-- Load the colorscheme here.
			-- Like many other themes, this one has different styles, and you could load
			-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
			-- NOTE: colorscheme is set in `after/plugin/color.lua`
			vim.cmd.colorscheme("tokyonight-night")

			-- You can configure highlights by doing something like:
			vim.cmd.hi("Comment gui=none")
		end,
		config = function ()
		end
	},

	{
		-- Highlight todo, notes, etc in comments
		-- Examples:
		-- FIX:
		-- BUG:
		-- ISSUE:
		-- TODO:
		-- HACK:
		-- WARN:
		-- WARNING:
		-- PERF:
		-- NOTE:
		-- TEST:

		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = true },
	},
}
