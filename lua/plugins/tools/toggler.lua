---@type LazySpec
return { -- Toggle Visual-selected values like true/false
  "nguyenvukhang/nvim-toggler",

  keys = {
    "<leader>i",
  },

  opts = {
    inverses = { -- Custom inverses
      ["based"] = "cringe",
      ["min"] = "max",
      ["MIN"] = "MAX",
      ["inner"] = "outer",
    },
  },
}
