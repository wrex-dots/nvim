---@type LazySpec
return { -- Toggle Visual-selected values like true/false
  "nguyenvukhang/nvim-toggler",

  event = "VeryLazy",

  opts = {
    inverses = { -- Custom inverses
      ["based"] = "cringe",
    },
  },
}
