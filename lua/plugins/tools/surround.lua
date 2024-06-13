return {
  {
    "kylechui/nvim-surround",

    keys = {
      "ys",
      "ds",
      "cs",
      "<S-s>",
    },

    init = function() vim.keymap.del({ "n" }, "<S-s>") end,

    config = true,
  },
}
