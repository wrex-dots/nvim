local function plug(mod) return require("plugins.ui.windows." .. mod) end

return {
  plug "auto-resize",
  plug "scroll-bar",
  plug "smooth-scrolling",
  plug "line-numbers",
}
