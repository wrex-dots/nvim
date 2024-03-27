local function Tele(action, ...)
  local opts = { n = select("#", ...), ... }
  return function() vim.cmd.Telescope(action, unpack(opts)) end
end

return require("foxutils.keys").lazy({
  {
    "<leader>ff",
    Tele "find_files",
    desc = "File picker",
  },
  {
    "<leader>fg",
    Tele "live_grep",
    desc = "Live GREP",
  },
  {
    "<leader>fb",
    Tele "buffers",
    desc = "Buffer picker",
  },
  {
    "<F9>",
    Tele "quickfix",
    desc = "Quickfix list",
  },
  {
    "<F8>",
    Tele "treesitter",
    desc = "TreeSitter tags",
  },
  {
    "<S-F8>",
    Tele "lsp_document_symbols",
    desc = "LSP Synbols",
  },
  {
    "<F11>",
    Tele("diagnostics", "bufnr=0"),
    desc = "LSP diagnostics",
  },
  {
    "<C-F11>",
    Tele "diagnostics",
    desc = "LSP diagnostics (all buffers)",
  },
  {
    "gr",
    Tele "lsp_references",
    desc = "LSP References",
  },
  {
    "gd",
    Tele "lsp_definitions",
    desc = "LSP Definitions",
  },
  {
    "gt",
    Tele "lsp_type_definitions",
    desc = "LSP Type definitions",
  },
  {
    "gi",
    Tele "lsp_implementations",
    desc = "LSP Implementations",
  },
}, {
  mode = { "n", "x" },
  silent = true,
  noremap = true,
  prefix = "Telescope: ",
})
