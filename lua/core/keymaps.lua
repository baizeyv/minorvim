-- DESC: this file is the default key mappings configuration file.
--
-- NOTE: modes: normal(n) visual(v) visual_block(x) insert(i) terminal(t) command(c) -> maybe useful

-- main table
local M = {}
-- noremap and silent option
local opt_ns = { noremap = true, silent = true }
-- only silent option
local opt_s = { silent = true }

-- NOTE: arg1: key or command || arg2: desc || arg3: options

-- general keymaps
M.common = {
    -- all modes
    [""] = {
        ["u"] = { "k", "move up", opts = opt_ns },
        ["e"] = { "j", "move down", opts = opt_ns },
		["gu"] = { "gk", "up", opts = opts_ns },
		["ge"] = { "gj", "down", opts = opts_ns },
        ["n"] = { "h", "move left", opts = opt_ns },
        ["i"] = { "l", "move right", opts = opt_ns },
        ["U"] = { "5k", "move up 5x", opts = opt_ns },
        ["E"] = { "5j", "move down 5x", opts = opt_ns },
        ["N"] = { "0", "move to begin of current line", opts = opt_ns },
        ["I"] = { "$", "move to end of current line", opts = opt_ns },
        ["W"] = { "5w", "move to next word 5x", opts = opt_ns },
        ["B"] = { "5b", "move to previous word 5x", opts = opt_ns },
        ["h"] = { "e", "", opts = opt_ns },
        [",."] = { "%", "match symbol", opts = opt_ns },
        ["<C-u>"] = { "5<C-y>", "scroll up", opts = opt_ns },
        ["<C-e>"] = { "5<C-e>", "scroll down", opts = opt_ns }
    },
    -- normal mode
    n = {
        [";"] = { ":", "toggle command line" },
		["S"] = { ":w<cr>", "save file" },
		["Q"] = { ":q<cr>", "quit neovim" },
		["l"] = { "u", "undo", opts = opt_ns },
		["k"] = { "i", "insert", opts = opt_ns },
		["K"] = { "I", "insert", opts = opt_ns },
		["<leader><cr>"] = { ":nohlsearch<cr>", "no highlight search", opts = opt_s },
		["<leader>o"] = { "za", "fold code" }, -- need set the fold level option
		["="] = { "n", "search next", opts = opt_ns },
		["-"] = { "N", "search previous", opts = opt_ns },
		["s"] = { "<nop>", "nop s" },
		["<space>"] = { "<nop>", "nop space" },
		-- some configuration of split windows
		["su"] = { ":set nosplitbelow<cr>:split<cr>:set splitbelow<cr>", "split up", opts = opt_s },
		["se"] = { ":set splitbelow<cr>:split<cr>", "split down", opts = opt_s },
		["sn"] = { ":set nosplitright<cr>:vsplit<cr>:set splitright<cr>", "split left", opts = opt_s },
		["si"] = { ":set splitright<cr>:vsplit<cr>", opts = opt_s },
		["<leader>u"] = { "<C-w>k", "select up", opts = opt_ns },
		["<leader>e"] = { "<C-w>j", "select down", opts = opt_ns },
		["<leader>n"] = { "<C-w>h", "select left", opts = opt_ns },
		["<leader>i"] = { "<C-w>l", "select right", opts = opt_ns },
		["<leader>w"] = { "<C-w>w", "select next", opts = opt_ns },
		-- some configuration of indentation
		["<"] = { "<<", "indent left", opts = opt_ns },
		[">"] = { ">>", "indent right", opts = opt_ns },

		["<leader>bi"] = { ":bnext<cr>", "", opts = opt_s },
		["<leader>bn"] = { ":bprevious<cr>", "", opts = opt_s }
    },
    -- visual mode
	v = {
		["Y"] = { "\"+y", "copy" },
		["<"] = { "<gv", "indent left", opts = opt_ns },
		[">"] = { ">gv", "indent right", opts = opt_ns },
		["<A-e>"] = { ":m .+1<cr>==", "move current line to below", opts = opt_s },
		["<A-u>"] = { ":m .-2<cr>==", "move current line to above", opts = opt_s },
		["P"] = { '"_dP', "paste", opts = opt_ns }
	},
    -- insert mode
	i = {},
	-- visual block mode
	x = {
		["<A-e>"] = { ":move '>+1<cr>gv-gv", "", opts = opt_s },
		["<A-u>"] = { ":move '<-2<cr>gv-gv", "", opts = opt_s }
	},
	-- command mode
	c = {
		["<A-i>"] = { "<Right>", "", opts = opt_ns },
		["<A-n>"] = { "<Left", "", opts = opt_ns },
		["<A-u>"] = { "<Up>", "", opts = opt_ns },
		["<A-e>"] = { "<Down>", "", opts = opt_ns }
	},
	-- terminal mode
	t = {}
}

-- TODO: plugins key mappings

return M
