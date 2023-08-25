local function Trouble(mode)
  return function()
    vim.cmd.Trouble(mode)
  end
end

---@type LazySpec[]
return {
  {
    "folke/trouble.nvim",

    dependencies = { "nvim-tree/nvim-web-devicons" },

    keys = require("foxutils").keys.lazy({
      {
        "<leader>tt",
        vim.cmd.TroubleToggle,
        desc = "Open Trouble",
      },
      {
        "<leader>tw",
        Trouble("workspace_diagnostics"),
        desc = "Workspace diagnostics",
      },
      {
        "<leader>td",
        Trouble("document_diagnostics"),
        desc = "Document diagnostics",
      },
      {
        "<leader>tq",
        Trouble("quickfix"),
        desc = "Quickfix list",
      },
      {
        "<leader>tl",
        Trouble("loclist"),
        desc = "Location list",
      },
      {
        "gr",
        Trouble("lsp_references"),
        desc = "LSP References",
      },
    }, {
      mode = "n",
      prefix = "Trouble: ",
      noremap = true,
      silent = true,
    }),
  },
}
