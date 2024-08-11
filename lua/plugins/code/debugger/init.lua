-- LazVim
local fox = require "foxutils"

---@type LazyPluginSpec
local spec = {
  "mfussenegger/nvim-dap",

  dependencies = {
    {
      "theHamsta/nvim-dap-virtual-text",

      dependencies = "nvim-treesitter/nvim-treesitter",

      config = true,
    },
  },

  keys = function()
    local function dap(command)
      return function() require("dap")[command]() end
    end
    local function repl(command)
      return function() require("dap").repl[command]() end
    end

    return fox.keys.lazy({
      {
        "<F1>",
        dap "toggle_breakpoint",
        desc = "Toggle breakpoint",
      },
      {
        "<F2>",
        dap "step_into",
        desc = "Step into",
      },
      {
        "<F3>",
        dap "step_over",
        desc = "Step over",
      },
      {
        "<F4>",
        dap "continue",
        desc = "Start/Continue",
      },
      {
        "<S-F4>",
        dap "continue",
        desc = "Restart",
      },
      {
        "<F5>",
        repl "toggle",
        desc = "Toggle REPL",
      },
    }, {
      mode = { "n", "i" },
      noremap = true,
      prefix = "DAP: ",
    })
  end,

  config = function()
    local completion = require "dap.ext.autocompl"

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dap-repl",
      group = vim.api.nvim_create_augroup(
        "AttachDapCompletion",
        { clear = true }
      ),
      callback = function() completion.attach() end,
    })

    vim.fn.sign_define(
      "DapBreakpoint",
      { text = "🛑", texthl = "", linehl = "", numhl = "" }
    )
  end,
}

return spec
