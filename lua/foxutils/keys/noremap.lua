local map = require('foxutils.keys.map').set

--- Set a non-remappable keymap using Vim's API
---@param desc  string The descritpion that will be shown for your mapping when calling :map
---@param mode  mode   The mode that your keymap will work in
---@param lhs   string A NeoVim keymap string
---@param rhs   rhs    The action yout keymap will trigger
---@param opts? optmap A table of options
local set = function (desc, mode, lhs, rhs, opts)
  opts = opts or {}
  local finalopts = vim.tbl_deep_extend('keep', { noremap = true }, opts)
  map(desc, mode, lhs, rhs, finalopts)
end

return {
  set = set,

  --- Set a keymap for Insert mode
  ---@param desc  string The descritpion that will be shown for your mapping when calling :map
  ---@param lhs   string A NeoVim keymap string
  ---@param rhs   rhs    The action yout keymap will trigger
  ---@param opts? optmap A table of options
  i = function (desc, lhs, rhs, opts)
    set(desc, 'i', lhs, rhs, opts)
  end,

  --- Set a keymap for Normal mode
  ---@param desc  string The descritpion that will be shown for your mapping when calling :map
  ---@param lhs   string A NeoVim keymap string
  ---@param rhs   rhs    The action yout keymap will trigger
  ---@param opts? optmap A table of options
  n = function (desc, lhs, rhs, opts)
    set(desc, 'n', lhs, rhs, opts)
  end,

  --- Set a keymap for Visual and Select mode
  ---@param desc  string The descritpion that will be shown for your mapping when calling :map
  ---@param lhs   string A NeoVim keymap string
  ---@param rhs   rhs    The action yout keymap will trigger
  ---@param opts? optmap A table of options
  x = function (desc, lhs, rhs, opts)
    set(desc, 'x', lhs, rhs, opts)
  end,

  --- Set a keymap for Visual mode
  ---@param desc  string The descritpion that will be shown for your mapping when calling :map
  ---@param lhs   string A NeoVim keymap string
  ---@param rhs   rhs    The action yout keymap will trigger
  ---@param opts? optmap A table of options
  v = function (desc, lhs, rhs, opts)
    set(desc, 'v', lhs, rhs, opts)
  end,
}
