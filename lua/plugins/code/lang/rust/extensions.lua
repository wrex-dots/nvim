---@type LazyPluginSpec
local crates = {
  "saecki/crates.nvim",

  tag = "stable",

  event = "BufRead Cargo.toml",

  opts = {
    src = { coq = { enabled = true } },
    null_ls = { enabled = true },
  },
}

---@type LazyPluginSpec
local ferris = {
  "vxpm/ferris.nvim",
}

return {
  crates,
  ferris,
}
