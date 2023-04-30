local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- shorten function name
local keybind = vim.api.nvim_set_keymap

-- remap space as leader key
keybind("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- modes:
-- normal -> n
-- visual -> v
-- visual block -> x
-- term mode -> t
-- command -> c
--

keybind("n", ";", ":", opts)
keybind("n", "s", "<Nop>", opts)
keybind("n", "S", ":w<CR>", opts) -- save file
keybind("n", "Q", ":q<CR>", opts) -- exit neovim
keybind("n", "l", "u", opts) -- undo
keybind("n", "k", "i", opts)
keybind("n", "K", "I", opts)
keybind("v", "Y", "\"+y", opts)
keybind("n", "<LEADER><CR>", ":nohlsearch<CR>", opts)
keybind("n", "<LEADER>o", "za", opts)

keybind("n", "=", "n", opts)
keybind("n", "-", "N", opts)

keybind("x", "k", "i", opts)
keybind("x", "K", "I", opts)

keybind("", "u", "k", opts)
keybind("", "n", "h", opts)
keybind("", "i", "l", opts)
keybind("", "e", "j", opts)
keybind("", "U", "5k", opts)
keybind("", "E", "5j", opts)
keybind("", "N", "0", opts)
keybind("", "I", "$", opts)
keybind("", "W", "5w", opts)
keybind("", "B", "5b", opts)
keybind("", "<C-u>", "5<C-y>", opts)
keybind("", "<C-e>", "5<C-e>", opts)
keybind("", "h", "e", opts)
keybind("n", ".", "n", opts)
keybind("n", ",", "N", opts)
keybind("", "<LEADER>,.", "%", opts)

keybind("n", "su", ":set nosplitbelow<CR>:split<CR>:set splitbelow<CR>", opts)
keybind("n", "se", ":set splitbelow<CR>:split<CR>", opts)
keybind("n", "sn", ":set nosplitright<CR>:vsplit<CR>:set splitright<CR>", opts)
keybind("n", "si", ":set splitright<CR>:vsplit<CR>", opts)
keybind("n", "<LEADER>u", "<C-w>k", opts)
keybind("n", "<LEADER>e", "<C-w>j", opts)
keybind("n", "<LEADER>n", "<C-w>h", opts)
keybind("n", "<LEADER>i", "<C-w>l", opts)
keybind("n", "<LEADER>w", "<C-w>w", opts)

keybind("n", "<", "<<", opts)
keybind("n", ">", ">>", opts)

keybind("c", "<C-n>", "<Left>", opts)
keybind("c", "<C-i>", "<Right>", opts)
keybind("c", "<C-u>", "<Up>", opts)
keybind("c", "<C-e>", "<Down>", opts)

keybind("v", "<", "<gv", opts)
keybind("v", ">", ">gv", opts)

keybind("v", "<A-e>", ":m .+1<CR>==", opts)
keybind("v", "<A-u>", ":m .-2<CR>==", opts)
keybind("v", "p", '"_dP', opts)

keybind("x", "<A-e>", ":move '>+1<CR>gv-gv", opts)
keybind("x", "<A-u>", ":move '<-2<CR>gv-gv", opts)

keybind("n", "<LEADER>bi", ":bnext<CR>", opts)
keybind("n", "<LEADER>bn", ":bprevious<CR>", opts)

-- ---------- split line ---------- --

-- NOTE: plugin -> todo-commends keymaps

vim.keymap.set("n", "?e", function()
	require("todo-comments").jump_next()
end, { desc = "next todo comment" })

vim.keymap.set("n", "?u", function()
	require("todo_comments").jump_prev()
end, { desc = "previous todo comment" })
