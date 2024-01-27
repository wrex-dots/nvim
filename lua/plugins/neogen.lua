local fox = require("foxutils")

function generate(type)
	return function()
		require("neogen").generate({
			type = type,
		})
	end
end

---@type Array<LazySpec>
return {
	{
		"danymat/neogen",

		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"L3MON4D3/LuaSnip",
		},

		keys = fox.keys.lazy({
			{
				"<C-i>t",
				generate("type"),
				desc = "Create type annotation for current context",
			},
			{
				"<C-i>f",
				generate("func"),
				desc = "Create function annotation for current context",
			},
			{
				"<C-i>b", -- b as in buffer
				generate("file"),
				desc = "Create file annotation for current context",
			},
			{
				"<C-i>c",
				generate("class"),
				desc = "Create class annotation for current context",
			},
		}, {
			mode = { "n", "i" },
			prefix = "Neogen: ",
			noremap = true,
		}),

		config = function()
			local jsLikeConfig = {
				template = {
					annotation_convention = "tsdoc",
				},
			}

			require("neogen").setup({
				enabled = true,
				snippet_engine = "luasnip",
				languages = {
					typescript = jsLikeConfig,
					javascript = jsLikeConfig,
					typescriptreact = jsLikeConfig,
					javascriptreact = jsLikeConfig,
				},
			})
		end,
	},
}
