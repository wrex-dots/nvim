local fox = require "foxutils"
local function plug(mod) return require("plugins.ui.file-tree." .. mod) end

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

  keys = fox.keys.lazy({
    {
      "<C-n>",
      vim.cmd.NvimTreeToggle,
      desc = "Toggle",
    },
    {
      "<M-n>",
      vim.cmd.NvimTreeFocus,
      desc = "Focus",
    },
  }, {
    prefix = "NvimTree: ",
    mode = { "n", "i", "x" },
    silent = true,
    noremap = true,
  }),

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

    on_attach = plug "on_attach",
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
