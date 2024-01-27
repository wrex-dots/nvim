local fox = require("foxutils")

---@type LazySpec[]
return {
	{
		"kdheepak/lazygit.nvim",

		cond = fox.systemhas("lazygit"),

		dependencies = {
			"nvim-lua/plenary.nvim",
		},

		init = function()
			vim.g.lazygit_floating_window_use_plenary = 1
		end,

		keys = fox.keys.lazy({
			{
				"<leader>gg",
				vim.cmd.LazyGit,
				desc = "Open pop-up",
			},
			{
				"<leader>gc",
				vim.cmd.LazyGitConfig,
				desc = "Open config",
			},
			{
				"<leader>gf",
				vim.cmd.LazyGitFilter,
				desc = "Open project commits",
			},
			{
				"<leader>gb",
				vim.cmd.LazyGitFilterCurrentFile,
				desc = "Open buffer commits",
			},
		}, {
			prefix = "LazyGit: ",
			mode = "n",
			noremap = true,
		}),
	},
}
