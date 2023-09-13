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
			local masonlsp = require("mason-lspconfig")
			local lspconfig = require("lspconfig")
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
					["lua_ls"] = function()
						lspconfig.lua_ls.setup({
							capabilities = capabilities,
							on_init = function(client)
								local path = client.workspace_folders[1].name
								if
									not vim.loop.fs_stat(path .. "/.luarc.json")
									and not vim.loop.fs_stat(path .. "/.luarc.jsonc")
								then
									client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
										Lua = {
											runtime = {
												-- Tell the language server which version of Lua you're using
												-- (most likely LuaJIT in the case of Neovim)
												version = "LuaJIT",
											},
											-- Make the server aware of Neovim runtime files
											workspace = {
												checkThirdParty = false,
												library = {
													vim.env.VIMRUNTIME,
													-- "${3rd}/luv/library"
													-- "${3rd}/busted/library",
												},
												-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
												-- library = vim.api.nvim_get_runtime_file("", true)
											},
										},
									})

									client.notify(
										"workspace/didChangeConfiguration",
										{ settings = client.config.settings }
									)
								end
								return true
							end,
						})
					end,
					["tsserver"] = function()
						local language_settings = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = false,
								includeInlayVariableTypeHintsWhenTypeMatchesName = false,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						}

						lspconfig.tsserver.setup({
							capabilities = capabilities,
							init_options = {
								-- This is the default which would be overwritten otherwise
								hostInfo = "neovim",
								-- 16 gb
								maxTsServerMemory = 16384,
								-- Never use LSP for syntax anyway
								tsserver = { useSyntaxServer = "never" },
							},
							settings = {
								["javascript"] = language_settings,
								["typescript"] = language_settings,
								["javascriptreeact"] = language_settings,
								["typescriptreact"] = language_settings,
							},
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
			"williamboman/mason-lspconfig.nvim",
		},

		config = function()
			require("mason-null-ls").setup({
				ensure_installed = {
					-- Formatters
					"prettierd", -- HTML, CSS, TS/JS, JSON, YANL...
					"stylua", -- Lua

					-- Linters
					-- "eslint_d", -- TS, JS (breaks)
					"eslint", -- TS, JS
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
