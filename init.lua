require("core")

local custom_init_file_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]
if custom_init_file_path then
	dofile(custom_init_file_path)
end

require("core.helper").load_init()
require("core.bootstrap").lazy()
require("plugins")
