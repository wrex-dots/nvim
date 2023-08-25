---@type Array<LazySpec>
return {
	{
		"williamboman/mason.nvim",

		build = ":MasonUpdate",

		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",

		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			{
				"lvimuser/lsp-inlayhints.nvim",
				config = function()
					vim.api.nvim_create_autocmd("LspAttach", {
						group = vim.api.nvim_create_augroup("LspAttachInlayHints", {}),
						callback = function(ev)
							if not (ev.data and ev.data.client_id) then
								return
							end

							local bufnr = ev.buf
							local client = vim.lsp.get_client_by_id(ev.data.client_id)
							require("lsp-inlayhints").on_attach(client, bufnr)
						end,
					})
				end,
			},
		},

		config = function()
			local lspconfig = require("lspconfig")
			local masonlsp = require("mason-lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			masonlsp.setup({
				-- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
				-- This setting has no relation with the `ensure_installed` setting.
				-- Can either be:
				--   - false: Servers are not automatically installed.
				--   - true: All servers set up via lspconfig are automatically installed.
				--   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
				--       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
				---@type boolean | { exclude: string[] }
				automatic_installation = true,

				-- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
				-- This setting has no relation with the `automatic_installation` setting.
				-- Get a list of available LSPs here: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
				---@type string[]
				ensure_installed = {
					"bashls",
					"jsonls",
					"lua_ls",
					"marksman",
					"tsserver",
					"vimls",
				},

				-- See `:h mason-lspconfig.setup_handlers()`
				---@type table<string, fun(server_name: string)>?
				handlers = {
					function(name)
						lspconfig[name].setup({ capabilities = capabilities })
					end,
					["tsserver"] = function()
						local inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = false,
							includeInlayVariableTypeHintsWhenTypeMatchesName = false,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						}
						lspconfig.tsserver.setup({
							javascript = { inlayHints = inlayHints },
							typescript = { inlayHints = inlayHints },
							javascriptreeact = { inlayHints = inlayHints },
							typescriptreact = { inlayHints = inlayHints },
						})
					end,
				},
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",

		event = "Syntax *",

		dependencies = {
			"williamboman/mason.nvim",
		},

		config = function()
			require("mason-null-ls").setup({
				ensure_installed = {
					-- Formatters
					"prettierd", -- HTML, CSS, TS/JS, JSON, YANL...
					"stylua", -- Lua

					-- Linters
					-- "eslint_d", -- TS, JS
					"selene", -- Lua
					"actionlint", -- Github actions
					"vint", -- VimScript
				},

				automatic_installation = true,

				handlers = {},
			})
		end,
	},
}
