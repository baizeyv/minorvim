local plugins = {
	{ "nvim-lua/plenary.nvim" }
}

local config = require("core.helper").load_config()
if #config.plugins > 0 then
	table.insert(plugins, { import = config.plugins })
end

require("lazy").setup(plugins, config.lazy)

if config.lazy_disable_home then
	require("plugins.helper").load_lazy_home_key()
end
