-- LazyVim

---@type LazyPluginSpec
local spec = {
  "akinsho/toggleterm.nvim",

  version = "*",

  keys = function()
    local fox = require "foxutils"
    local function toggle(direction)
      return function() vim.cmd.ToggleTerm("direction=" .. direction) end
    end

    return fox.keys.lazy({
      {
        "<F11>",
        toggle "horizontal",
        desc = "Open horizontal",
      },
      {
        "<S-F11>",
        toggle "float",
        desc = "Open float",
      },
    }, {
      prefix = "ToggleTerm: ",
      mode = { "n", "v", "i", "t" },
    })
  end,

  init = function()
    vim.api.nvim_create_autocmd("TermOpen", {
      desc = "Set Terminal mode keymaps",
      pattern = "term://*",
      group = vim.api.nvim_create_augroup(
        "TermOpenSetKeymaps",
        { clear = true }
      ),
      callback = function(event)
        require("foxutils.keys").noremap.t(
          "Terminal: Leave Terminal mode",
          "<esc><esc>",
          [[<C-\><C-n>]],
          { buffer = 0 }
        )

        if event.file:match ".*#toggleterm#.*" then
          vim.opt_local.winbar = "%= ::" .. vim.b.toggle_number .. "%="
        end
      end,
    })
  end,

  opts = {
    autochdir = true,
    direction = "horizontal",
    shell = function()
      -- Check if user has defined $SHELL, use that one preferably.
      -- Otherwise use Vim's shell option which should always have something.
      local shell = vim.fn.expand "$SHELL"
      return shell ~= "" and shell or vim.o.shell
    end,
  },
}

return spec
