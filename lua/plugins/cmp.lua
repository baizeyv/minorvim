-- TODO: this file is unfinished

--   פּ ﯟ   some other good icons
local icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

local M = {
	"hrsh7th/nvim-cmp",
	lazy = true,
	config = function()
		require("cmp").setup({
			-- todo
			snippet = {
				expand = function(args)
					-- vim.fn["vsnip#anonymous"](args.body) -- vsnip plugin
					-- require("luasnip").lsp_expand(args.body) -- luasnip plugin
					-- vim.fn["UltiSnips#Anon"](args.body) -- ultisnips plugin
				end
			},
			window = {
				completion = require("cmp").window.bordered(),
				documentation = require("cmp").window.bordered()
			},
			mapping = require("cmp").mapping.preset.insert({
				-- todo
				["<C-u>"] = require("cmp").mapping.select_prev_item(),
				["<C-e>"] = require("cmp").mapping.select_next_item(),
				['<CR>'] = require("cmp").confirm({ select = true })
			}),
			sources = require("cmp").config.sources({
				-- todo
				-- { name = 'nvim_lsp' },
				-- { name = 'vsnip' },
				-- { name = 'luasnip' },
				-- { name = 'ultisnips' },
				-- { name = 'snippy' }
			}),
			experimental = {
				ghost_text = false,
				native_menu = false
			},
			confirm_opts = {
				behavior = cmp.ConfirmBehavior.Replace,
				select = false
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, item)
					-- kind icons
					item.kind = string.format("%s", icons[item.kind])
					item.menu = ({
						luasnip = "[Snippet]",
						buffer = "[Buffer]",
						path = "[Path]"
					})[entry.source.name]
					return item
				end,
			}
		})
		
	end
}

return { M }
