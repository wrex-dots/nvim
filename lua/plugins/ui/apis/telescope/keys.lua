return function()
  local tele = require "telescope.builtin"
  local ext = require("telescope").extensions
  local fox = require "foxutils"

  return fox.keys.lazy({
    {
      "<leader>ff",
      tele.find_files,
      desc = "File picker",
    },
    {
      "<leader>fg",
      tele.live_grep,
      desc = "Live GREP",
    },
    {
      "<leader>fb",
      tele.buffers,
      desc = "Buffer picker",
    },
    {
      "<leader>fj",
      ext.emoji.emoji,
      desc = "Emoji picker",
    },
    {
      "<leader>fqf",
      tele.quickfix,
      desc = "Quickfix list",
    },
    {
      "<leader>fts",
      tele.treesitter,
      desc = "TreeSitter tags",
    },
    {
      "<leader>fds",
      tele.lsp_document_symbols,
      desc = "LSP Synbols",
    },
    {
      "<leader>dd",
      function() tele.diagnostics "bufnr=0" end,
      desc = "LSP diagnostics",
    },
    {
      "<leader>dD",
      tele.diagnostics,
      desc = "LSP diagnostics (all buffers)",
    },
    {
      "gr",
      tele.lsp_references,
      desc = "LSP References",
    },
    {
      "gd",
      tele.lsp_definitions,
      desc = "LSP Definitions",
    },
    {
      "gt",
      tele.lsp_type_definitions,
      desc = "LSP Type definitions",
    },
    {
      "gi",
      tele.lsp_implementations,
      desc = "LSP Implementations",
    },
  }, {
    mode = { "n", "x" },
    silent = true,
    noremap = true,
    prefix = "Telescope: ",
  })
end
