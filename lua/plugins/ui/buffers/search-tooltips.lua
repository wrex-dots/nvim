---@type LazyPluginSpec
local spec = {
  "kevinhwang91/nvim-hlslens",

  dependencies = { "kevinhwang91/nvim-ufo" },

  keys = { "/", "?" },

  init = function()
    -- Enable search highlighting
    vim.opt.hlsearch = true

    -- Disable search highlights by pressing `<leader><Enter>` in normal or visual mode
    vim.keymap.set(
      { "n", "v" },
      "<leader><Cr>",
      function() vim.opt.hlsearch = false end,
      { noremap = true }
    )
  end,
}

return spec
