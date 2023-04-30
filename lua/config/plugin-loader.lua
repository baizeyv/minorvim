-- lazy.nvim packages manager

local fn = vim.fn

local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath) -- run time path

-- main panel keymaps configuration
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
	plugins = true,
}
commands.restore = {
    button = true,
    desc = "Updates all plugins to the state in the lockfile. For a single plugin: restore it to the state in the lockfile or to a given commit under the cursor",
    desc_plugin = "Restore a plugin to the state in the lockfile or to a given commit under the cursor",
    id = 8,
    key = "R",
    key_plugin = "r",
    plugins = true,
}
commands.profile = {
    button = true,
    desc = "Show detailed profiling",
    id = 9,
    key = "P",
    toggle = true,
}
commands.debug = {
    button = true,
    desc = "Show debug information",
    id = 10,
    key = "D",
    toggle = true,
}
commands.help = {
    button = true,
    desc = "Toggle this help page",
    id = 11,
    key = "?",
    toggle = true,
}
commands.clear = {
    desc = "Clear finished tasks",
    id = 12,
}
commands.load = {
    desc = "Load a plugin that has not been loaded yet. Similar to `:packadd`. Like `:Lazy load foo.nvim`. Use `:Lazy! load` to skip `cond` checks.",
    id = 13,
    plugins = true,
    plugins_required = true,
}
commands.health = {
    desc = "Run `:checkhealth lazy`",
    id = 14,
}
commands.build = {
    desc = "Rebuild a plugin",
    id = 13,
    plugins = true,
    plugins_required = true,
    key_plugin = "gb",
}

-- setup (init) configuration
require("lazy").setup({
	root = fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
	defaults = { -- always use the lastest git commit
		lazy = true,
		vesion = false
	},
	spec = {
		{ import = "plugins" },
	},
	lockfile = fn.stdpath("config") .. "/lazy-lock.json",
	concurrency = 10,
	git = {
		log = { "--since=3 days ago" },
		timeout = 120,
		url_format = "https://github.com/%s.git",
		filter = true
	},
	checker = { enabled = true },
	install = {
		missing = true,
		colorscheme = { "tokyonight", "gruvbox" }
	},
	ui = {
    -- a number <1 is a percentage., >1 is a fixed size
    size = { width = 0.8, height = 0.8 },
    wrap = true, -- wrap the lines in the ui
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = "none",
    icons = {
		cmd = " ",
		config = "",
      event = "",
      ft = " ",
      init = " ",
      import = " ",
      keys = " ",
      lazy = "󰒲 ",
      loaded = "●",
      not_loaded = "○",
      plugin = " ",
      runtime = " ",
      source = " ",
      start = "",
      task = "✔ ",
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
	-- leave nil, to automatically select a browser depending on your OS.
    -- If you want to use a specific browser, you can define it here
    browser = nil, ---@type string?
    throttle = 20, -- how frequently should the ui process render events
    custom_keys = {
      -- you can define custom key maps here.
      -- To disable one of the defaults, set it to false

      -- open lazygit log
      ["<localleader>l"] = function(plugin)
        require("lazy.util").float_term({ "lazygit", "log" }, {
          cwd = plugin.dir,
        })
      end,

      -- open a terminal for the plugin dir
      ["<localleader>t"] = function(plugin)
        require("lazy.util").float_term(nil, {
          cwd = plugin.dir,
        })
      end,
    },
  },
  performance = {
	rtp = {
		-- disable some rtp plugins
		disabled_plugins = {
			"gzip",
			"netrwPlugin",
			"tarPlugin",
			"tohtml",
			"tutor",
			"zipPlugin"
		}
	}
  }
})
