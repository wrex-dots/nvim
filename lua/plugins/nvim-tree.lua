local fox = require("foxutils")

return {
	"nvim-tree/nvim-tree.lua",

	dependencies = {
		"nvim-tree/nvim-web-devicons",
		{
			"antosha417/nvim-lsp-file-operations",
			dependencies = { "nvim-lua/plenary.nvim" },
      config = true,
		},
	},

	keys = fox.keys.lazy({
		{
			"<C-n>",
			vim.cmd.NvimTreeToggle,
			desc = "Toggle",
		},
		{
			"<M-n>",
			vim.cmd.NvimTreeFocus,
			desc = "Focus",
		},
	}, {
		prefix = "NvimTree: ",
		mode = { "n", "i", "x" },
		silent = true,
		noremap = true,
	}),

	init = function()
		-- Disable netrw (Vim's default tree explorer)
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- Set termguicolors to enable highlight groups.
		-- This might be enabled elsewhere, but you're never too sure.
		vim.opt.termguicolors = true
	end,

	opts = {
		sort = {
			sorter = "filetype",
		},

		sync_root_with_cwd = true,
    respect_buf_cwd = true,

		view = {
			width = 50,
		},

		renderer = {
			group_empty = true,
		},

		filters = {
			dotfiles = true,
		},

		update_focused_file = {
			enable = true,
		},

		on_attach = function(bufno)
			local api = require("nvim-tree.api")
			local tree, node, config = api.tree, api.node, api.config

			local function delmap(mapping)
				vim.keymap.del("n", mapping, { buffer = bufno })
			end

			local function setmap(mapping, desc, command)
				vim.keymap.set("n", mapping, command, {
					desc = "nvim-tree: " .. desc,
					buffer = bufno,
					noremap = true,
					silent = true,
					nowait = true,
				})
			end

			config.mappings.default_on_attach(bufno)

			local toDelete = {
				"<2-LeftMouse>", -- Open
				"<2-RightMouse>", -- CD
				"<C-]>", -- CD
				"-", -- CD intro parent
				">", -- Next sibling
				"<", -- Prev sibling
				"J", -- Last sibling
				"g?", -- Help
				"<C-K>", -- Info
				"<C-V>", -- Open split (vertical)
				"<C-X>", -- Open split (horizontal)
			}

			local toAdd = {
				{
					"?",
					"Help",
					tree.toggle_help,
				},
				{
					"<S-K>",
					"Info",
					node.show_info_popup,
				},
				{
					"cd",
					"CD into selected node",
					tree.change_root_to_node,
				},
				{
					"..",
					"CD into parent node",
					tree.change_root_to_parent,
				},
				{
					"<C-BS>",
					"Collapse all dirs",
					function()
						tree.collapse_all(true)
					end,
				},
				{
					"v",
					"Open split (vertical)",
					node.open.vertical,
				},
				{
					"h",
					"Collapse all dirs",
					node.open.horizontal,
				},
			}

			for _, map in ipairs(toDelete) do
				delmap(map)
			end

			for _, map in ipairs(toAdd) do
				setmap(unpack(map))
			end
		end,
	},

	config = function(_, opts)
		local evt = require("nvim-tree.api").events

		-- Doesn't work ?
		evt.subscribe(evt.Event.FileCreated, function(file)
			vim.cmd.edit(file.name)
		end)

		require("nvim-tree").setup(opts)
	end,
}
