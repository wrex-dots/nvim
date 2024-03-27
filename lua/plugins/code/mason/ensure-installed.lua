---@class ServerList
---@field [number] string
---@field add      fun(self, srv: string | string[]): self
local ServerList = {}

---@param langs string | string[]
function ServerList:add(langs)
  local t = type(langs)

  if t == "string" then
    table.insert(self, langs)
  elseif t == "table" then
    for _, lang in ipairs(langs) do
      table.insert(self, lang)
    end
  else
    error(
      "Not a valid language server name (type = "
        .. vim.inspect(t)
        .. "): "
        .. vim.inspect(langs),
      2
    )
  end

  return self
end

local EI = {
  ["mason"] = setmetatable({}, { __index = ServerList }),
  ["null-ls"] = setmetatable({}, { __index = ServerList }),
}

return EI
