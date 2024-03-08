local fox = require("foxutils")

return {
	{
		"neovim/nvim-lspconfig",

		event = "Syntax *",

		dependencies = {
			{ -- Get annotations in your Vim configurtation and plugin dev files
				"folke/neodev.nvim",
				config = true,
			},
			{ -- Wrapper around `vim.lsp.buf.format` to avoid formatting with ALL formatters at once
				"fmbarina/pick-lsp-formatter.nvim",
				dependencies = {
					"stevearc/dressing.nvim",
					"nvim-telescope/telescope.nvim",
				},
				main = "plf",
				opts = {
					find_project = true,
					when_unset = function()
						return _G["PLF_SHOULD_OPEN_PICKER"]
					end,
				},
			},
		},

		config = function()
			-- Vim's default update time makes LSP functions very slow.
			-- 1/3 of a second makes it much more snappy, set it to a higher value
			-- for slower LSP analysis, but higher performance.
			vim.o.updatetime = 300

			-- Global mappings
			fox.keys.batch({
				noremap = {
					n = {
						{ "Open diagnostics", "<leader><S-d>", vim.diagnostic.open_float },
						{ "Go to next diagnostic", "<leader>dn", vim.diagnostic.goto_next },
						{ "Go to prev diagnostic", "<leader>dp", vim.diagnostic.goto_prev },
						{ "Restart all atached LSPs", "<F12>", vim.cmd.LspRestart },
					},
				},
			})

			-- Buffer specific settings
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspKeysOnAttach", {}),
				callback = function(ev)
					local buf = vim.lsp.buf

					local function async_format()
						require("plf").format({ async = true })
					end

					local function pick_formatter()
						require("plf").pick_format()
					end

					fox.keys.batch({
						noremap = {
							n = {
								{ "Show documentation", "<S-K>", buf.hover },
								{ "Show signature help", "<C-K>", buf.signature_help },
								{ "Go to declaration", "gD", buf.declaration },
								{ "Rename symbol", "<F2>", buf.rename },
								{ "Format document", "<F10>", async_format },
								{ "Select default formatter", "<C-F10>", pick_formatter },
							},
							i = {
								{ "Format document", "<F10>", async_format },
								{ "Select default formatter", "<C-F10>", pick_formatter },
							},
						},
					}, {
						buffer = ev.buffer,
					})
				end,
			})

      if vim.fn.has "nvim-0.10" == 1 then
        local InlayHintsToggle =
          vim.api.nvim_create_augroup("InlayHintsToggle", {})

        vim.api.nvim_create_autocmd({ "InsertEnter" }, {
          group = InlayHintsToggle,
          callback = function() vim.lsp.buf.inlay_hint(0, true) end,
        })
        vim.api.nvim_create_autocmd({ "InsertLeave" }, {
          group = InlayHintsToggle,
          callback = function() vim.lsp.buf.inlay_hint(0, false) end,
        })
      end
    end,
  },
}
