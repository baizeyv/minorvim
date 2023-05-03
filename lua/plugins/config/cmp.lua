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

local cmp = require("cmp")

local M = {}

M.options = { -- TODO:
	snippet = {
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- vsnip plugin
			-- require("luasnip").lsp_expand(args.body) -- luasnip plugin
			-- vim.fn["UltiSnips#Anon"](args.body) -- ultisnips plugin
		end
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered()
	},
	mapping = cmp.mapping.preset.insert({
		-- todo
		["<C-u>"] = cmp.mapping.select_prev_item(),
		["<C-e>"] = cmp.mapping.select_next_item(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-q>"] = cmp.mapping {
			i = cmp.mapping.abort(),
			c = cmp.mapping.close()
		},
		["<C-Space>"] = cmp.mapping.complete(),
		["<A-u>"] = cmp.mapping.scroll_docs(-1),
		["<A-e>"] = cmp.mapping.scroll_docs(1),
		["<C-y>"] = cmp.config.disable, -- Specify 'cmp.config.disable'
		["<Tab>"] = cmp.mapping(
			function(fallback) -- TODO: snip
				if cmp.visible() then
					cmp.select_next_item()
				elseif check_backspace() then
					fallback()
				else
					fallback()
				end
			end, { "i", "s" }
		),
		["<S-Tab>"] = cmp.mapping(
			function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end, { "i", "s" }
		)
	}),
	sources = cmp.config.sources({
		-- todo
		-- { name = 'nvim_lsp' },
		-- { name = 'vsnip' },
		-- { name = 'luasnip' },
		-- { name = 'ultisnips' },
		-- { name = 'snippy' }
		{ name = 'path', options = {} },
		{ name = 'buffer', options = { keyword_pattern = [[\k\+]] } }
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
		end
	}
}

M.execute = function()
	cmp.setup.cmdline(
		'/', {
			mapping = cmp.mapping.preset.cmdline({
				["<C-u>"] = {
					c = function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end
				},
				["<C-e>"] = {
					c = function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end
				}
			}),
			sources = {
				{ name = 'buffer' }
			}
		}
	)
	cmp.setup.cmdline(
		':', {
			mapping = cmp.mapping.preset.cmdline({
				["<C-u>"] = {
					c = function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end
				},
				["<C-e>"] = {
					c = function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end
				}
			}),
			sources = cmp.config.sources({
				{ name = 'path' }
			}, {{
					name = 'cmdline',
					options = {
						ignore_cmds = { 'Man', '!' }
					}
				}
			})
		}
	)
end

return M
