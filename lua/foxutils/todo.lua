local TODOS = {
	"conf: Use fox.keys.lazy wherever possible",
	"conf: Simplify foxutils.keys.batch",
	"conf: Cleanup NvimTree config's horrid key setup",
	"conf: Maybe make a TODO plugin",
	"conf: Investigate inlay hints not working w/ TSServer",
	"conf: Fix the fucking <Tab> input",
	"conf: Set some more ergonomic keys for Telescope file picker",
}

for _, todo in ipairs(TODOS) do
	vim.notify("[TODO] " .. todo, vim.log.levels.INFO)
end
