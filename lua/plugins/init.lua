-- all plugins have lazy = true by default, to load a plugin on startup just lazy = false
-- list of all default plugins & their definitions

local default_plugins = {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme tokyonight]])
		end
	}
}

local config = require("core").config
local lib = require("plugins.lib")

require("lazy").setup(default_plugins, config.lazy_nvim)
if config.lazy_custom_key then
    lib.load_lazy_home_key()
end
