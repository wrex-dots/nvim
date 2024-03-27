---@type LazyPluginSpec
local spec = {
  "declancm/cinnamon.nvim",

  keys = {
    "<PageUp>",
    "<PageDown>",
    "<C-u>",
    "<C-d>",
  },

  config = function()
    require("cinnamon").setup {
      extra_keymaps = true,
      extended_keymaps = true,
    }

    vim.keymap.set(
      { "i", "n", "x" },
      "<PageUp>",
      [[ <Cmd>lua Scroll('<C-u>', 1, 1)<CR> ]]
    )
    vim.keymap.set(
      { "i", "n", "x" },
      "<PageDown>",
      [[ <Cmd>lua Scroll('<C-d>', 1, 1)<CR> ]]
    )
  end,
}

return spec
