---@class LazyKeyOptions
---@field mode?    string|string[]
---@field noremap? boolean
---@field remap?   boolean
---@field expr?    boolean

---@class LazyKey: LazyKeyOptions
---@field [1]   string                 lhs
---@field [2]?  string | fun() | false rhs
---@field desc? string

---@class LazyKeyBuilderOptions: LazyKeyOptions
---@field prefix? string Prefix for the keys' description

---Build an array of keys complying with `LazyPluginSpec`'s `keys` property.
---@param keys  LazyKey[]             A table of keys to set up
---@param opts? LazyKeyBuilderOptions Default options to apply to all the keys (will not override per-key options)
---@return LazyKeys[]
return function(keys, opts)
  opts = opts or {}
  local prefix = opts.prefix
  opts.prefix = nil

  local function mapfn(key)
    if prefix and key.desc then key.desc = prefix .. key.desc end
    return vim.tbl_extend("keep", key, opts)
  end

  return vim.tbl_map(mapfn, keys)
end
