-- TODO:
local M = {}

M.options = {
	normal = {},
	append = {}
}

M.keymaps = {}

M.plugins = require("plugins.config.lazy")

M.lazy_disable_home = true

return M
