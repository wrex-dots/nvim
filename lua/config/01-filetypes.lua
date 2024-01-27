---@see Pattern :h pattern
---|
---@alias FtPattern
---| string         # A vim pattern
---| Array<string>  # An array of vim patterns

---@alias Filetype string # A filetype to assign to files matching given patterns

---@alias FtOverride Table<FtPattern, Filetype>

---@type Array<FtOverride>
local overrides = {
	{
		"*.map",
		"json",
	},
	{
		"*.json",
		"jsonc",
	},
	{
		"\\cdockerfile",
		"dockerfile",
	},
	{
		".envrc",
		"sh",
	},
}

local augroup = vim.api.nvim_create_augroup("FileTypeOverrides", {})

for _, override in ipairs(overrides) do
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		group = augroup,
		pattern = override[1],
		command = "set ft=" .. override[2],
	})
end
