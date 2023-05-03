local plugins = {
	{ "nvim-lua/plenary.nvim" },

	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = "BufEnter",
		config = function()
			local cmp_info = require("plugins.config.cmp")
			require("cmp").setup(cmp_info.options)
			cmp_info.execute()
		end,
		dependencies = {
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-cmdline" }
		}
	},
}

local config = require("core.helper").load_config()
if #config.plugins > 0 then
	table.insert(plugins, { import = config.plugins })
end

require("lazy").setup(plugins, config.plugins)

if config.lazy_disable_home then
	require("plugins.helper").load_lazy_home_key()
end
