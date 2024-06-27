local mappers = {
  map = require "foxutils.keys.map",
  noremap = require "foxutils.keys.noremap",
}

local function is_batch_table(t)
  assert(t.type ~= "table", "Must pass a table")
  return t
end

local function batchmap_mode(maplist, mapper, globalopts)
  globalopts = globalopts or {}
  local desc, lhs, rhs, mapopts, opts

  for _, map in ipairs(maplist) do
    desc, lhs, rhs, mapopts = unpack(map)
    mapopts = mapopts or {}
    opts = vim.tbl_extend("keep", mapopts or {}, globalopts)
    mapper(desc, lhs, rhs, opts)
  end
end

local function batchmap_category(cat, batch, opts)
  print(unpack(batch))
  for mode, maplist in pairs(batch) do
    batchmap_mode(maplist, mappers[cat][mode], opts)
  end
end

--- Set a bunch of mappings all at once
--- Example:
--- ```lua
--- local fox = require('foxutils')
--- fox.keys.batch {
---   map = {
---     n = {
---       {
---         'Map Enter to :DoSomething in current buffer',
---         '<CR>',
---         ':DoSomething',
---         { buffer = true }
---       },
---     },
---   },
---   noremap = {
---     v = {
---       {
---         'Map Escape to :DoOtherThing (silent)',
---         '<ESC>',
---         ':doOtherThing',
---         { silent = true }
---       }
---     },
---   },
--- }
--- ```
---@param maptable MapBatch   A whole bunch of mappings 😌
---@param opts?    MapOptions Options to apply to ALL of the mappings (options set in mappings will have precedence)
local function batchmap(maptable, opts)
  local t = is_batch_table(maptable)

  for cat, batch in pairs(t) do
    batchmap_category(cat, batch, opts)
  end
end

return batchmap
