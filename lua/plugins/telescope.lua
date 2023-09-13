local fox = require("foxutils")

local no_ripgrep_message = [[
I recommend you install RipGrep on your machine (or make it available in your PATH).
Installing it will immediately greatly improve Telescope's perofmance.
  => https://github.com/BurntSushi/ripgrep
]]

local no_fd_message = [[
I recommend you install fd on your machine (or make it available in your PATH).
Installing it will immediately greatly improve Telescope's perofmance.
  => https://github.com/sharkdp/fd
]]

return {
	{
		"nvim-telescope/telescope.nvim",

		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},

		keys = fox.keys.lazy({
			{
				"<leader>ff",
				function()
					vim.cmd.Telescope("find_files")
				end,
				desc = "File picker",
			},
			{
				"<leader>fg",
				function()
					vim.cmd.Telescope("live_grep")
				end,
				desc = "Live GREP",
			},
			{
				"<leader>fb",
				function()
					vim.cmd.Telescope("buffers")
				end,
				desc = "Buffer picker",
			},
			{
				"<leader>ft",
				function()
					vim.cmd.Telescope("treesitter")
				end,
				desc = "TreeSitter tags",
			},
			{
				"<leader>fq",
				function()
					vim.cmd.Telescope("quickfix")
				end,
				desc = "Quickfix list",
			},
			{
				"<leader>flD",
				function()
					vim.cmd.Telescope("diagnostics")
				end,
				desc = "LSP diagnostics (all buffers)",
			},
			{
				"<leader>fls",
				function()
					vim.cmd.Telescope("lsp_document_symbols")
				end,
				desc = "LSP Synbols",
			},
			{
				"<leader>fld",
				function()
					vim.cmd.Telescope("diagnostics", "bufnr=0")
				end,
				desc = "LSP diagnostics",
			},
			{
				"gr",
				function()
					vim.cmd.Telescope("lsp_references")
				end,
				desc = "LSP References",
			},
			{
				"gd",
				function()
					vim.cmd.Telescope("lsp_definitions")
				end,
				desc = "LSP Definitions",
			},
			{
				"gt",
				function()
					vim.cmd.Telescope("lsp_type_definitions")
				end,
				desc = "LSP Type definitions",
			},
			{
				"gi",
				function()
					vim.cmd.Telescope("lsp_implementations")
				end,
				desc = "LSP Implementations",
			},
		}, {
			mode = { "n", "x" },
			silent = true,
			noremap = true,
			prefix = "Telescope: ",
		}),

		init = function()
			if not fox.systemhas("rg") then
				vim.notify(no_ripgrep_message, vim.log.levels.INFO)
			end
			if not fox.systemhas("fd") then
				vim.notify(no_fd_message, vim.log.levels.INFO)
			end
		end,

		config = function()
			local tele = require("telescope")
			tele.setup({})
			tele.load_extension("fzf")

			local load_extension_if_requireable = function(module, nameIfDifferentFromModule)
				local ok, _ = pcall(require(module))
				if not ok then
					return
				end
				tele.load_extension(nameIfDifferentFromModule or module)
			end

			local extensions = {
				{ "scope" },
			}

			for _, ext in ipairs(extensions) do
				load_extension_if_requireable(ext[1], ext[2])
			end
		end,
	},
}
