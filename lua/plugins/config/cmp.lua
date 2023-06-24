local M = {}
local lspkind = require 'lspkind'
local cmp = require 'cmp'
local luasnip = require 'luasnip'

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

M.options = {
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered()
	},
	mapping = cmp.mapping.preset.insert({
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
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif has_words_before then
					cmp.complete()
				else
					fallback()
				end
			end, { "i", "s" }
		),
		["<S-Tab>"] = cmp.mapping(
			function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }
		)
	}),
	experimental = {
		ghost_text = true
	},
	sources = cmp.config.sources({
		{ name = 'luasnip' },
		{ name = 'nvim_lsp' },
		{ 
			name = 'buffer', 
			options = { 
				keyword_pattern = [[\k\+]],
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end
			} 
		},
		{ 
			name = 'path', 
			options = {
				trailing_slash = false,
				label_trailing_slash = true
			} 
		},
	}),
	sorting = {
		comparators = {
			function(...)
				return require('cmp_buffer'):compare_locality(...)
			end
		}
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = lspkind.cmp_format(require("plugins.config.lspkind"))
	}
}

local map = cmp.mapping.preset.cmdline({
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
})

M.execute = function()
	cmp.setup.cmdline(
		'/', {
			mapping = map,
			sources = {
				{ name = 'buffer' }
			}
		}
	)
	cmp.setup.cmdline(
		':', {
			mapping = map,
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
