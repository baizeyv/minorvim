-- :help options

local options = {
	autochdir = true, -- auto change directory to current path
	backup = false, -- creates a backup file
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	cmdheight = 2, -- more space in the neovim command line for displaying messages
	completeopt = { "longest", "noinsert", "menuone", "noselect", "preview" },
	inccommand = "split",
	conceallevel = 0, -- so that `` is visible in markdown files
	cursorline = true,
	exrc = true,
	fileencoding = "utf-8", -- the encoding written to a file
	hlsearch = true, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	number = true, -- set numbered lines
	numberwidth = 4, -- set number colummn width
	relativenumber = true, -- set relative numbered lines
	expandtab = false, -- convert tabs to spaces
	tabstop = 4, -- insert 4 spaces for a tab
	shiftwidth = 4, -- the number of spaces inserted for each indentation
	softtabstop = 4,
	list = true,
	scrolloff = 7,
	ttimeoutlen = 0,
	timeout = false,
	wrap = true,
	foldmethod = "indent",
	foldlevel = 99,
	foldenable = true,
	timeoutlen = 1000,
	mouse = "a",
	pumheight = 10, -- pop up menu height
	showmode = false,
	showtabline = 2, -- always show tabs
	smartcase = true,
	smartindent = true,
	splitbelow = true,
	splitright = true,
	swapfile = false,
	undofile = true,
	updatetime = 100,
	writebackup = false,
	signcolumn = "yes",
	lazyredraw = true,
	virtualedit = "block"
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.opt.shortmess:append "c"
vim.opt.listchars:append('eol:↴')
-- vim.opt.listchars:append('eol:↵')
vim.opt.listchars:append('tab:⇥ ')
vim.opt.listchars:append('extends:›') -- when wrap is off
vim.opt.listchars:append('trail:▫')

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
