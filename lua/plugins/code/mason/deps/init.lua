local function plug(mod) return require("plugins.code.mason.deps." .. mod) end

---@type LazySpec[]
local deps = {
  "neovim/nvim-lspconfig",
  "fmbarina/pick-lsp-formatter.nvim",

  -- JSON / YAML
  "b0o/SchemaStore.nvim",

  plug "mason",
  plug "ctags",
}

return deps
