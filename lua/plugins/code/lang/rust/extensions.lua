---@type LazyPluginSpec
local crates = {
  "saecki/crates.nvim",

  tag = "stable",

  event = "BufRead Cargo.toml",

  opts = {
    completion = { coq = { enabled = true }, name = "Crates" },
    null_ls = { enabled = true },
  },
}

---@type LazyPluginSpec
local ferris = {
  "vxpm/ferris.nvim",

  config = true,
}

return {
  crates,
  ferris,
}
