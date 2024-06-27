-- LazyVim

local exts = require "plugins.ui.apis.telescope.exts"

---@type LazyPluginSpec
local fzf = {
  "nvim-telescope/telescope-fzf-native.nvim",

  build = "make",
}

---@type LazyPluginSpec
local emoji = {
  "xiyaowong/telescope-emoji.nvim",

  init = function()
    ---@class EmojiDescription
    ---@field name        string
    ---@field value       string
    ---@field category    string
    ---@field description string

    exts["emoji"] = {

      ---@param e EmojiDescription
      --[[ action = function(e)
        -- insert emoji when picked
        vim.api.nvim_put({ e.value }, "c", false, true)
      end, ]]
    }
  end,
}

---@type LazyPlugin[]
return {
  fzf,
  emoji,
}
