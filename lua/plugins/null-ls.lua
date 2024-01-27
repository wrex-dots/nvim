---@type LazySpec[]
return {
	{
		"nvimtools/none-ls.nvim",

		dependencies = {
			"nvim-lua/plenary.nvim",
			"jay-babu/mason-null-ls.nvim",
		},

		event = "VeryLazy",

		config = true,
	},
}
