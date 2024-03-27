---@alias ProviderPath string
---@alias ProviderName string # Must be a valid provider variable name, like `node_host_prog`
---@alias ProviderSpec table<ProviderName, ProviderPath>

---@type ProviderSpec[]
local providerSpecs = {
  { "node_host_prog", "/usr/bin/neovim-node-host" },
}

for _, spec in ipairs(providerSpecs) do
  vim.g[spec[1]] = spec[2]
end
