return {
	{
		"mbbill/undotree",

		cond = vim.fn.has("persistent_undo"),

		init = function()
			local undocache = vim.fn.stdpath("config") .. "/.undotree"

			if not vim.loop.fs_stat(undocache) then
				vim.notify("Creating undotree cache at [" .. undocache .. "]")
				vim.fn.mkdir(undocache, "p", tonumber("777", 8))
			else
				assert(vim.fn.isdirectory(undocache), "Cache path " .. undocache .. " is not a directory!")
			end

			vim.o.undodir = undocache
			vim.o.undofile = true
			vim.g.undotree_WindowLayout = 4
		end,

		keys = {
			{
				"<F5>",
				vim.cmd.UndotreeToggle,
				desc = "Toggle UndoTree",
				mode = "n",
				silent = true,
				noremap = true,
			},
		},
	},
}
