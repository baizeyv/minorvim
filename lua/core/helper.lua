-- DESC: minor vim helper
-- TODO: this file

local M = {}
local merge_table = vim.tbl_deep_extend

M.load_init = function()
	M.load_options()
	M.load_keymaps()
end

-- load the default configuration file
M.load_config = function()
	-- default config
	local config = require("core.config")
	-- custom config path
	local minor_config_path = vim.api.nvim_get_runtime_file("lua/custom/minor.lua", false)[1]

	if minor_config_path then
		local minor_config = dofile(minor_config_path)
		config.keymaps = M.remove_default_keymaps(minor_config.keymaps, require "core.keymaps")
		config.options = M.remove_default_options(minor_config.options, require "core.options")
		config = merge_table("force", config, minor_config)
	else
		config.keymaps = require "core.keymaps"
		config.options = require "core.options"
	end
	return config
end

-- load the key mappings configuration file
M.load_keymaps = function(section, mapping_opt)
	vim.schedule(function()
		local function set_map(map_values)
			if map_values.is_plugin then
				return
			end
			map_values.is_plugin = nil
			for mode, mode_values in pairs(map_values) do
				local default_opts = merge_table("force", { mode = mode }, mapping_opt or {})
				for keybind, mapping_info in pairs(mode_values) do
					local opts = merge_table("force", default_opts, mapping_info.opts or {})
					mapping_info.opts, opts.mode = nil, nil
					opts.desc = mapping_info[2]
					vim.api.nvim_set_keymap(mode, keybind, mapping_info[1], opts)
				end
			end
		end
		local keymaps = require("core.helper").load_config().keymaps
		if type(section) == "string" then
			keymaps[section]["is_plugin"] = nil
			keymaps = { keymaps[section] }
		end
		for _, v in pairs(keymaps) do
			set_map(v)
		end
	end)
end

-- load the options configuration file
M.load_options = function()
	local function set_opt(normal_tb, append_tb)
		for k, v in pairs(normal_tb) do
			vim.opt[k] = v
		end
		for k, v in pairs(append_tb) do
			vim.opt[k]:append(v)
		end
	end
	local options = require("core.helper").load_config().options
	set_opt(options.normal, options.append)
end

M.remove_default_options = function(custom_options, default_options)
	-- if `custom_options` is not exist
	if not custom_options then
		return default_options
	end

	local mark = {}
	-- store options in a array with true value to compare
	for k, _ in pairs(custom_options) do
		for key, _ in pairs(k) do
			mark[k][key] = true
		end
	end
	-- make a copy as we need to modify default_options
	for k, _ in pairs(default_options) do
		for key, _ in pairs(k) do
			if mark[k] then
				default_options[k][key] = nil
			end
		end
	end
	return default_options
end

M.remove_default_keys = function(custom_keymaps, default_keymaps)
	-- if `custom_keymaps` is not exist
	if not custom_keymaps then
		return default_keymaps
	end
	-- store keys in a array with true value to compare
	local mark = {}
	for _, maps in pairs(custom_keymaps) do
		for mode, mode_values in pairs(maps) do
			-- if the `mark[mode]` is not exist
			if not mark[mode] then
				-- init table
				mark[mode] = {}
			end

			for k, _ in pairs(mode_values) do
				mark[mode][k] = true
			end
		end
	end

	-- remove the spicific key mappings in default_keymaps
	for section, section_values in pairs(default_keymaps) do
		for mode, mode_values in pairs(section_values) do
			mode_values = (type(mode_values) == "table" and mode_values) or {}
			for k, _ in pairs(mode_values) do
				-- if key is found then remove from default_keymaps
				if mark[mode] and mark[mode][k] then
					default_keymaps[section][mode][k] = nil
				end
			end
		end
	end
	return default_keymaps
end

M.lazy_load = function(plugin)
	vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
		group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
		callback = function()
			local file = vim.fn.expand "%"
			local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""

			if condition then
				vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

				-- don't defer for treesitter as it will show slow highlighting
				-- This deferring only happens only when we do "nvim filename"
				if plugin ~= "nvim-treesitter" then
					vim.schedule(function()
						require("lazy").load { plugins = plugin }

						if plugin == "nvim-lspconfig" then
							vim.cmd "silent! do FileType"
						end
					end, 0)
				else
					require("lazy").load { plugins = plugin }
				end
			end
		end
	})
end

return M
