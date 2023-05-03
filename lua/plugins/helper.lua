local M = {}

M.load_lazy_home_key = function()
	local commands = require("lazy.view.config").commands
	commands.home = {
		button = true,
		desc = "Go back to plugin list",
		id = 1,
		key = "H"
	}
	commands.install = {
		button = true,
		desc = "Install missing plugins",
		desc_plugin = "Install a plugin",
		id = 2,
		key = "T",
		key_plugin = "t",
		plugins = true
	}
	commands.update = {
		button = true,
		desc = "Update plugins. This will also update the lockfile",
		desc_plugin = "Update a plugin, This will also update the lockfile",
		id = 3,
		key = "A",
		key_plugin = "a",
		plugins = true
	}
	commands.sync = {
		button = true,
		desc = "Run install, clean and update",
		desc_plugin = "Run install, clean and update",
		id = 4,
		key = "S",
		plugins = true
	}
	commands.clean = {
		button = true,
		desc = "Clean plugins that are no longer needed",
		desc_plugin = "Delete a plugin. WARNING: this will delete the plugin even if it should be installed!",
		id = 5,
		key = "X",
		key_plugin = "x",
		plugins = true
	}
	commands.check = {
		button = true,
		desc = "Check for updates and show the log (git fetch)",
		desc_plugin = "Check for updates and show the log (git fetch)",
		id = 6,
		key = "C",
		key_plugin = "c",
		plugins = true
	}
	commands.log = {
		button = true,
		desc = "Show recent updates",
		desc_plugin = "Show recent updates",
		id = 7,
		key = "L",
		key_plugin = "l",
		plugins = true
	}
	commands.restore = {
		button = true,
		desc = "Updates all plugins to the state in the lockfile. For a single plugin: restore it to the state in the lockfile or to a given commit under the cursor",
		desc_plugin = "Restore a plugin to the state in the lockfile or to a given commit under the cursor",
		id = 8,
		key = "R",
		key_plugin = "r",
		plugins = true
	}
	commands.profile = {
		button = true,
		desc = "Show detailed profiling",
		id = 9,
		key = "P",
		toggle = true
	}
	commands.debug = {
		button = true,
		desc = "Show debug information",
		id = 10,
		key = "D",
		toggle = true
	}
	commands.help = {
		button = true,
		desc = "Toggle this help page",
		id = 11,
		key = "?",
		toggle = true
	}
	commands.clear = {
		desc = "Clear finished tastk",
		id = 12
	}
	commands.load = {
		desc = "Load a plugin that has not been loaded yet. Similar to `:packadd`. Like `:Lazy load foo.nvim`. Use `:Lazy! load` to skip `cond` checks",
		id = 13,
		plugins = true,
		plugins_required = true
	}
	commands.health = {
		desc = "Run `:checkhealth lazy`",
		id = 14
	}
	commands.build = {
		desc = "Rebuild a plugin",
		id = 15,
		plugins = true,
		plugins_required = true,
		key_plugin = "gb"
	}
end

return M
