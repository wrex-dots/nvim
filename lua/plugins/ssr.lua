---@type LazySpec
return {
  {
    "cshuaimin/ssr.nvim",

    keys = fox.keys.lazy({
      {
        "<C-F2>",
        function() require("ssr").open() end,
        desc = "Start",
      },
    }, {
      prefix = "Structural Search and Replace: ",
      mode = { "i", "v", "n" },
      noremap = true,
    }),
  },
}
