---@type LazySpec[]
return {
	{
		"henrywallace/null-ls.nvim",

		dependencies = {
			"nvim-lua/plenary.nvim",
			"jay-babu/mason-null-ls.nvim",
		},

		event = "VeryLazy",

		config = function()
			require("null-ls").setup({
				on_attach = function(client, bufno)
					if client.supports_method("textDocument/formatting") then
						vim.notify("Buffer supports LSP formating. Registering autocommand...", vim.log.levels.INFO)
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = vim.api.nvim_create_augroup("FormatOnSave", {}),
							buffer = bufno,
							callback = function(ev)
								vim.lsp.buf.format({
									buffer = ev.buffer,
									async = false,
								})
							end,
						})
					else
						vim.notify("Buffer doesn't support LSP formatting.", vim.log.levels.INFO)
					end
				end,
			})
		end,
	},
}
