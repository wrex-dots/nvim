local function plug(mod) return require("plugins.code." .. mod) end

local code = {
  plug "mason",
  plug "nvim-lspconfig",
  plug "TreeSitter",

  plug "completion",
  plug "code-actions-menu",
  plug "comment",
}

for _, language_plugin in pairs(require("plugins.code.lang").plugins) do
  table.insert(code, language_plugin)
end

return code
