local vim = vim

local ROCK_TREE = vim.fs.normalize(vim.fn.stdpath("data") .. "/image.nvim/")

---@type Array<LazyKey>
return {
  {
    "3rd/image.nvim",

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },

    ft = { "markdown", "vimwiki", "norg" },
    event = "BufEnter *.jpe?g,*.gif,*.webp,*.png",

    cond = function()
      local has = require("foxutils.systemhas")

      return has("kitty") and has("luarocks") and has("lua5.1") and has("magick")
    end,

    build = "luarocks --tree " .. ROCK_TREE .. " --lua-version=5.1 install magick;",

    init = function()
      package.path = package.path
        .. ";"
        .. vim.fn.system("luarocks --lua-version=5.1 --tree " .. ROCK_TREE .. " path --lr-path")
    end,

    opts = {
      backend = "kitty",
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = 80,
      max_height_window_percentage = 50,
      window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs" },
      editor_only_render_when_focused = true, -- auto show/hide images when the editor gains/looses focus
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
    },
  },
}
