-- all plugins have lazy = true by default, to load a plugin on startup just lazy = false
-- list of all default plugins & their definitions

local default_plugins = {
	-- tokyonight colorscheme
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme tokyonight]])
		end
	},
	{
		"hrsh7th/nvim-cmp",
		event = "BufEnter",
		dependencies = {
			{
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"onsails/lspkind.nvim",
			},
			{
				"windwp/nvim-autopairs",
				event = "InsertEnter"
			},
			{
				"L3MON4D3/LuaSnip",
				version = "<CurrentMajor>.*",
				build = "make install_jsregexp",
				dependencies = {
					"rafamadriz/friendly-snippets",
				},
				opts = {
					history = true,
					delete_check_events = "TextChanged",
					enable_autosnippets = true,
					store_selection_keys = "`"
				},
				config = function(_, opts)
					require("plugins.config.luasnip").luasnip(opts)
				end
			},
		},
		opts = function()
			return require("plugins.config.cmp")
		end,
		config = function(_, opts)
			require("cmp").setup(opts.options)
			opts.execute()
		end
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			{
				"williamboman/mason.nvim",
				build = ":MasonUpdate",
				cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
				opts = function()
					return require("plugins.config.mason")
				end,
				config = function(_, opts)
					require("mason").setup(opts.mason)
					require("mason-lspconfig").setup(opts.mason_lspconfig)
				end
			},
		},
		opts = function()
			return require("plugins.config.lsp")
		end,
		config = function(_, opts)
			opts.execute()
		end
	},






	--[[{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		opts = {
			-- add any custom options here
			dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
			options = {
				"buffers", "curdir", "tabpages", "winsize"
			},
			pre_save = nil -- a function to call bffore saving the session
		}
	},]]--
	--[[{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim"
		},
		keys = {
			{ "<leader>ss", ":Telescope find_files<CR>", desc = "find files record name" },
			{ "<leader>sf", ":Telescope live_grep<CR>", desc = "grep files context" },
			{ "<leader>sr", ":Telescope resume<CR>", desc = "resume" },
			{ "<leader>so", ":Telescope oldfiles<CR>", desc = "oldfiles" }
		}
	},]]--
	--[[{
		"folke/neodev.nvim",
		opts = {},
		config = function()
		end
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "VeryLazy",
		config = function()
			require("null-ls").setup({
				-- TODO
			})
		end
	},]]--
	--[[{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require'nvim-treesitter.configs'.setup {
			  -- A list of parser names, or "all" (the five listed parsers should always be installed)
			  ensure_installed = {  },
			  -- ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

			  -- Install parsers synchronously (only applied to `ensure_installed`)
			  sync_install = false,

			  -- Automatically install missing parsers when entering buffer
			  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			  auto_install = true,

			  -- List of parsers to ignore installing (for "all")
			  ignore_install = { "javascript" },

			  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
			  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

			  highlight = {
				enable = true,

				-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
				-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
				-- the name of the parser)
				-- list of language that will be disabled
				disable = { "c", "rust" },
				-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,

				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			  },
			}
		end
	}]]--
}

local config = require("core").config
local lib = require("plugins.lib")

require("lazy").setup(default_plugins, config.lazy_nvim)
if config.lazy_custom_key then
    lib.load_lazy_home_key()
end
