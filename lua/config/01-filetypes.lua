---@see Pattern :h pattern
--
---@alias Pattern
--| string         # A vim pattern
--| Array<string>  # An array of vim patterns

---@alias Filetype string # A filtype to assign to files matching given patterns

---@alias FtOverride Table<Pattern, Filetype>

---@type Array<FtOverride>
local overrides = {
	{
		"*.json",
		"jsonc",
	},
	{
		"*.map",
		"json",
	},
	{
		"\\cdockerfile",
		"docker",
	},
}

local augroup = vim.api.nvim_create_augroup("FileTypeOverrides", {})

for _, override in ipairs(overrides) do
	vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
		group = augroup,
		pattern = override[1],
		command = "setfiletype " .. override[2],
	})
end
