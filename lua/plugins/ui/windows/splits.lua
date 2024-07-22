---@type LazyPluginSpec
local splitborders = {
  "nvim-zh/colorful-winsep.nvim",

  event = "WinLeave",

  init = function()
    -- Make the horizontal split separator be a thin straight line
    -- We override whatever has been set in order to make it look nice with this plugin.
    -- Did you set fillchars somewhere else but they kept getting overridden and you have been looking for minutes,
    -- hours, days, years even? You have come to the right place and I'm sorry.
    vim.opt.fillchars:append { stl = "─", stlnc = "─"}

    -- Couldn't find a way to do this in "pure lua"
    vim.cmd [[highlight! link StatusLine WinSeparator]]
  end,

  config = true,
}

return splitborders
