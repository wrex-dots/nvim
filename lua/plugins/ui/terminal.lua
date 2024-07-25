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
        [[<C-\>]],
        desc = "Toggle terminal (supports motions)",
      },
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
      {
        "<C-F11>",
        vim.cmd.TermSelect,
        desc = "Open terminal picker",
      },
    }, {
      prefix = "ToggleTerm: ",
      mode = { "n", "v", "i", "t" },
    })
  end,

  init = function()
    vim.o.hidden = true -- Prevent terminals from getting discarded
    --                     when put in the background

    vim.api.nvim_create_autocmd("TermOpen", {
      desc = "Set Terminal mode keymaps",
      pattern = "term://*#toggleterm#*",
      group = vim.api.nvim_create_augroup("ToggleTermInit", { clear = true }),
      callback = function()
        vim.opt_local.winbar = "%= ::" .. vim.b.toggle_number .. "%="

        -- Require a double tap on <esc> to leave terminal mode.
        -- That way, TUIs that rely on <esc> to quit won't make you close the terminal
        -- window when you want out of them.
        require("foxutils.keys").noremap.t(
          "Terminal: Leave Terminal mode",
          "<esc><esc>",
          [[<C-\><C-n>]],
          { buffer = 0 }
        )
      end,
    })
  end,

  opts = {
    -- We do have F11 for quick toggle in a predefined layout.
    -- However, this one mapping supports motions, enabling stuff like opening a terminal
    -- with a chosen id (uint), like `2<C-n>`
    open_mapping = [[<C-\>]],

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
