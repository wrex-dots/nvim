vim.g.did_load_filetypes = 1

return {
	{
		"nathom/filetype.nvim",

		-- enanble = false,

		event = "VimEnter",

		opts = {
			overrides = {
				extensions = {
					map = "json",
					json = "jsonc",
				},
			},
		},
	},
}
