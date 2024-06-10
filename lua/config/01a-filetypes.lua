vim.filetype.add {
  extension = {
    ["rasi"] = "rasi",
    ["as"] = "actionscript",
  },
  pattern = {
    [".*/hypr/.*%.conf"] = "hyprlang",
    [".*/kitty/.*%.conf"] = "bash",
    [".*/mako/config"] = "dosini",
    [".*/waybar/config"] = "jsonc",
  },
}
