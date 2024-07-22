local M = {}

function M.set_fillchar(char)
  local patterns = {
    stl = "(stl:)[^,]+(,?)",
    stlnc = "(stlnc:)[^,]+(,?)",
  }

  local fillchars = vim.o.fillchars

  if #fillchars == 0 then
    vim.o.fillchars = string.format("stl:%s,stlnc:%s", char, char)
    return
  end

  local stlmatch, stlncmatch =
    vim.iter(fillchars:gmatch(patterns.stl)):next(),
    vim.iter(fillchars:gmatch(patterns.stlnc)):next()

  if stlmatch ~= nil then
    fillchars = fillchars:gsub(patterns.stl, "%1" .. char .. "%2")
  end

  if stlncmatch ~= nil then
    fillchars = fillchars:gsub(patterns.stlnc, "%1" .. char .. "%2")
  end

  vim.o.fillchars = fillchars
end

---@type LazyPluginSpec
M.spec = {
  "nvim-zh/colorful-winsep.nvim",

  event = "WinLeave",

  init = function()
    -- Make the horizontal split separator be a thin straight line
    -- We override whatever has been set in order to make it look nice with this plugin.
    -- Did you set fillchars somewhere else but they kept getting overridden and you have been looking for minutes,
    -- hours, days, years even? You have come to the right place and I'm sorry.
    M.set_fillchar "─"

    -- Couldn't find a way to do this in "pure lua"
    vim.cmd [[highlight! link StatusLine WinSeparator]]
  end,

  config = true,
}

return M
