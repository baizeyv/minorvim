-- DESC: this file is the default key mappings configuration file.
--
-- INFO: modes: normal(n) visual(v) visual_block(x) insert(i) terminal(t) command(c) -> maybe useful

-- TODO: change all desc

-- main table
local M = {}
-- noremap and silent option
local ns_opts = { noremap = true, silent = true }
-- only silent option
local s_opts = { silent = true }

-- NOTE: arg1: key or command || arg2: desc || arg3: opts

-- general keymaps
M.common = {
	-- all mode
	[""] = {
		["u"] = { "k", "move up", opts = ns_opts },
		["e"] = { "j", "move down", opts = ns_opts },
		["n"] = { "h", "move left", opts = ns_opts },
		["i"] = { "l", "move right", opts = ns_opts },
		["U"] = { "5k", "move up 5x", opts = ns_opts },
		["E"] = { "5j", "move down 5x", opts = ns_opts },
		["N"] = { "0", "move to begin", opts = ns_opts},
		["I"] = { "$", "move to end", opts = ns_opts },
		["W"] = { "5w", "next word", opts = ns_opts },
		["B"] = { "5b", "previous word", opts = ns_opts },
		["h"] = { "e", "", ns_opts },
		["<leader>,."] = { "%", "match symbol", opts = ns_opts },
		["<C-u>"] = { "5<C-y>", "scroll up", opts = ns_opts },
		["<C-e>"] = { "5<C-e>", "scroll down", opts = ns_opts }
	},
	-- normal mode
	n = {
		[";"] = { ":", "toggle command line" },
		["S"] = { ":w<cr>", "save file" },
		["Q"] = { ":q<cr>", "quit neovim" },
		["l"] = { "u", "undo", opts = ns_opts },
		["k"] = { "i", "insert", opts = ns_opts },
		["K"] = { "I", "insert", opts = ns_opts },
		["<leader><cr>"] = { ":nohlsearch<cr>", "no highlight search", opts = s_opts },
		["<leader>o"] = { "za", "fold code" }, -- need set the fold level option
		["."] = { "n", "search next", opts = ns_opts },
		[","] = { "N", "search previous", opts = ns_opts },
		["s"] = { "<nop>", "nop s" },
		["<space>"] = { "<nop>", "nop space" },
		-- some configuration of split windows
		["su"] = { ":set nosplitbelow<cr>:split<cr>:set splitbelow<cr>", "split up", opts = s_opts },
		["se"] = { ":set splitbelow<cr>:split<cr>", "split down", opts = s_opts },
		["sn"] = { ":set nosplitright<cr>:vsplit<cr>:set splitright<cr>", "split left", opts = s_opts },
		["si"] = { ":set splitright<cr>:vsplit<cr>", opts = s_opts },
		["<leader>u"] = { "<C-w>k", "select up", opts = ns_opts },
		["<leader>e"] = { "<C-w>j", "select down", opts = ns_opts },
		["<leader>n"] = { "<C-w>h", "select left", opts = ns_opts },
		["<leader>i"] = { "<C-w>l", "select right", opts = ns_opts },
		["<leader>w"] = { "<C-w>w", "select next", opts = ns_opts },
		-- some configuration of indentation
		["<"] = { "<<", "indent left", opts = ns_opts },
		[">"] = { ">>", "indent right", opts = ns_opts },

		["<leader>bi"] = { ":bnext<cr>", "", opts = s_opts },
		["<leader>bn"] = { ":bprevious<cr>", "", opts = s_opts }
	},
	-- visual mode
	v = {
		["Y"] = { "\"+y", "copy" },
		["<"] = { "<gv", "indent left", opts = ns_opts },
		[">"] = { ">gv", "indent right", opts = ns_opts },
		["<A-e>"] = { ":m .+1<cr>==", "move current line to below", opts = s_opts },
		["<A-u>"] = { ":m .-2<cr>==", "move current line to above", opts = s_opts },
		["P"] = { '"_dP', "paste", opts = ns_opts }
	},
	-- insert mode
	i = {},
	-- visual block mode
	x = {
		["<A-e>"] = { ":move '>+1<cr>gv-gv", "", opts = s_opts },
		["<A-u>"] = { ":move '<-2<cr>gv-gv", "", opts = s_opts }
	},
	-- command mode
	c = {
		["<A-i>"] = { "<Right>", "", opts = ns_opts },
		["<A-n>"] = { "<Left", "", opts = ns_opts },
		["<A-u>"] = { "<Up>", "", opts = ns_opts },
		["<A-e>"] = { "<Down>", "", opts = ns_opts }
	},
	-- terminal mode
	t = {}
}

-- TODO: plugins key mappings

return M
