local M = {}
local merge_table = vim.tbl_deep_extend

-- load configurations
M.load_config = function (config)
    M.load_options(config)
    M.load_keymaps(config)
end

M.load_options = function (config)
    local function set_opt(normal_tb, append_tb, g_tb)
        for k, v in pairs(normal_tb) do
            vim.opt[k] = v
        end
        for k, v in pairs(append_tb) do
            vim.opt[k]:append(v)
        end
        for k, v in pairs(g_tb) do
            vim.g[k] = v
        end
    end
    local options = config.options
    set_opt(options.normal, options.append, options.g)
end

M.load_keymaps = function (config, section, mapping_opt)
    vim.schedule(function ()
        local function set_section_map(section_values)
            if section_values.plugin then
                return
            end
            section_values.plugin = nil

            for mode, mode_values in pairs(section_values) do
                local default_opts = merge_table("force", { mode = mode }, mapping_opt or {})
                for keybind, mapping_info in pairs(mode_values) do
                    local opts = merge_table("force", default_opts, mapping_info.opts or {})

                    mapping_info.opts, opts.mode = nil, nil
                    opts.desc = mapping_info[2]
                    vim.keymap.set(mode, keybind, mapping_info[1], opts)
                end
            end
        end
        local mappings = config.keymaps
        if type(section) == "string" then
            mappings[section]["plugin"] = nil
            mappings = { mappings[section] }
        end

        for _, sect in pairs(mappings) do
            set_section_map(sect)
        end
    end)
end

-- get the configurations table (please view the config.lua)
M.get_config = function ()
    -- default configurations
    local config = require("core.config")
    -- custom configurations path
    local minor_config_path = vim.api.nvim_get_runtime_file("lua/custom/minor.lua", false)[1]
    if minor_config_path then
        local minor_config = dofile(minor_config_path)
        config.keymaps = M.remove_default_keys(minor_config.keymaps, require "core.keymaps")
        config.options = M.remove_default_options(minor_config.options, require "core.options")
        config = merge_table("force", config, minor_config)
    end
    return config
end

M.remove_default_options = function (custom_options, default_options)
    -- if `custom_options` is not exist
    if not custom_options then
        return default_options
    end

    local mark = {}
    -- store options in an array with true value to compared
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

M.remove_default_keys = function (custom_keymaps, default_keymaps)
    -- if `custom_keymaps` is not exist
    if not custom_keymaps then
        return default_keymaps
    end

    -- store keymaps in an array with true value to compared
    local mark = {}
    for _, maps in pairs(custom_keymaps) do
        for mode, mode_values in pairs(maps) do
            -- if the `mark[mode]` is not exist
            if not mark[mode] then
                mark[mode] = {}
            end

            for k, _ in pairs(mode_values) do
                mark[mode][k] = true
            end
        end
    end

    -- remove the specific key mappings in default_keymaps
    for k, v in pairs(default_keymaps) do
        for mode, mode_values in pairs(v) do
            mode_values = (type(mode_values) == "table" and mode_values) or {}
            for key, _ in pairs(mode_values) do
                -- if key is found then remove from default_keymaps
                if mark[mode] and mark[mode][key] then
                    default_keymaps[k][mode][key] = nil
                end
            end
        end
    end
    return default_keymaps
end

return M