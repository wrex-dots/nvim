local code = {
  require "plugins.code.mason",
  require "plugins.code.nvim-lspconfig",
  require "plugins.code.TreeSitter",
  require "plugins.code.debugger",

  require "plugins.code.snippets",
  require "plugins.code.completion",
  require "plugins.code.code-actions-menu",
  require "plugins.code.comment",
}

for _, language_plugin in pairs(require("plugins.code.lang").plugins) do
  table.insert(code, language_plugin)
end

return code
