--- Set a keymap using Vim's API
---@param desc  string     The descritpion that will be shown for your mapping when calling :map
---@param mode  MapModeStr The mode that your keymap will work in
---@param lhs   string     A NeoVim keymap string
---@param rhs   MapRHS     The action yout keymap will trigger
---@param opts? MapOptions A table of options
local function set(desc, mode, lhs, rhs, opts)
  opts = opts or {}
  local finalopts = vim.tbl_deep_extend("keep", { desc = desc }, opts)
  vim.keymap.set(mode, lhs, rhs, finalopts)
end

local function get_setter(mode)
  ---@param desc  string     The descritpion that will be shown for your mapping when calling :map
  ---@param lhs   string     A NeoVim keymap string
  ---@param rhs   MapRHS     The action yout keymap will trigger
  ---@param opts? MapOptions A table of options
  return function(desc, lhs, rhs, opts) set(desc, mode, lhs, rhs, opts) end
end

return {
  set = set,
  i = get_setter "i",
  n = get_setter "n",
  o = get_setter "o",
  t = get_setter "t",
  v = get_setter "v",
  x = get_setter "x",
}
