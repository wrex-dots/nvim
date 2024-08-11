local fox = require "foxutils"

---@type LazyPluginSpec
local spec = {
  "nvim-tree/nvim-tree.lua",

  dependencies = {
    "nvim-tree/nvim-web-devicons",
    {
      "antosha417/nvim-lsp-file-operations",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = true,
    },
  },

  keys = function()
    --- Execute an NvimTree API function
    ---@param fname string
    local function tree(fname)
      return function() require("nvim-tree.api").tree[fname]() end
    end

    return fox.keys.lazy({
      {
        "<C-n>",
        tree "toggle",
        desc = "Toggle",
      },
      {
        "<M-n>",
        tree "focus",
        desc = "Focus",
      },
    }, {
      prefix = "NvimTree: ",
      mode = { "n", "i", "x" },
      silent = true,
      noremap = true,
    })
  end,

  init = function()
    -- Disable netrw (Vim's default tree explorer)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Set termguicolors to enable highlight groups.
    -- This might be enabled elsewhere, but you're never too sure.
    vim.opt.termguicolors = true
  end,

  opts = {
    sort = {
      sorter = "filetype",
    },

    sync_root_with_cwd = true,
    respect_buf_cwd = true,

    view = {
      width = 50,
    },

    renderer = {
      group_empty = true,
    },

    filters = {
      dotfiles = true,
    },

    update_focused_file = {
      enable = true,
    },

    on_attach = require "plugins.ui.file-tree.on_attach",
  },

  config = function(_, opts)
    local evt = require("nvim-tree.api").events

    evt.subscribe(
      evt.Event.FileCreated,
      function(file) vim.cmd.edit(file.fname) end
    )

    require("nvim-tree").setup(opts)
  end,
}

return spec
