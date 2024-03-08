---@meta

---@alias FmtHook fun(client: lsp.Client, buffer: integer)

---@class LspTools
---@field lspconfig    any      Get with `require("lspconfig")`
---@field capabilities table    Completion capabilities
---@field hook_fmt     FmtHook A hook to automatically format on save, to be passed to `on_attach`

---@alias Handler fun(T: LspTools)
