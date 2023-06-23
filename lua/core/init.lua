local M = {}

M.lib = require("core.lib")

M.config = M.lib.get_config()

M.lib.load_config(M.config)

return M
