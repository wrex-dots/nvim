local function plug(mod) return require("plugins.tools." .. mod) end

return {
  plug "discord-rtp",
  plug "hexedit",
  plug "image-preview",
  plug "keys-helper",
  plug "lazygit",
  plug "per-project-config",
  plug "structural-search-replace",
  plug "surround",
  plug "toggler",
  plug "undotree",
  plug "wakatime",
}
