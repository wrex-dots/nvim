return {
	{
		"nvim-treesitter/nvim-treesitter",

		dependencies = {
			{ -- 🌈 Rainbow parenthesis
				"HiPhish/nvim-ts-rainbow2",
				enabled = false,
			},

			-- Automatic setting of the commentstring value based on cursor position
			"JoosepAlviste/nvim-ts-context-commentstring",

			{ -- Keep track of the current context as a sticky topline
				"nvim-treesitter/nvim-treesitter-context",
				opts = {
					enable = true,
					separator = "~",
				},
			},

			{ -- Automatic bracket pairing
				"windwp/nvim-autopairs",

				event = "Syntax *",

				opts = {
					check_ts = true,
				},
			},

			"nvim-treesitter/nvim-treesitter-refactor",

			{ -- Manipulate and move around text objects
				"nvim-treesitter/nvim-treesitter-textobjects",
			},
		},

		event = "VeryLazy",

		build = ":TSUpdate",

		init = function()
			vim.o.foldmethod = "expr"
			vim.o.foldexpr = "nvim_treesitter#foldexpr()"
			vim.o.foldminlines = 3
			vim.o.foldlevelstart = 20
			vim.o.foldcolumn = "auto"
		end,

		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,

				ensure_installed = {
					"lua",
					"javascript",
					"typescript",
					"tsx",
					"vim",
					"vimdoc",
				},

				indent = { enable = true },
				highlight = { enable = true },
				context_commentstring = { enable = true },
				incremental_selection = { enable = true },

				-- rainbow = {
				--   enable = true,
				--   strategy = require("ts-rainbow").strategy["local"],
				-- },

				textobjects = {
					select = { enable = true },
					swap = { enable = true },
					lsp_interop = { enable = true },
				},
			})
		end,
	},
}
