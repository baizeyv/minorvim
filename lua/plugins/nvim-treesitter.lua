local M = {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	priority = 1000,
	build = function()
		require("nvim-treesitter.install").update({ with_sync = true })
	end
}

return { M }
