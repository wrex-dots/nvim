local function plug(mod) return require("plugins.ui.apis." .. mod) end

return {
  plug "telescope",
  plug "dressing",
  plug "notifications",
}
