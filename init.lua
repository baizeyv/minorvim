require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
    dofile(custom_init_path)
end

local lazy_path = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim
if not vim.loop.fs_stat(lazy_path) then
	require("core.boot").lazy(lazy_path)
end
vim.opt.rtp:prepend(lazy_path)

require "plugins"
