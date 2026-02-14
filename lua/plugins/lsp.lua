return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v3.x",
	dependencies = {
		"neovim/nvim-lspconfig",

		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",

		-- completion
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lua",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
		-- snippets
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local lsp = require("lsp-zero")

		lsp.preset("recommended")
		lsp.setup()


		require("fidget").setup({})
		require("mason").setup({})
		require("mason-lspconfig").setup({ handlers = { lsp.default_setup } })

		local cmp = require("cmp")
		local luasnip = require("luasnip")
		cmp.setup({
			snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
			completion = {
				keyword_length = 1,
				autocomplete = {
					cmp.TriggerEvent.TextChanged,
				},
			},
			mapping = cmp.mapping.preset.insert({
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.confirm({ select = true })
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						cmp.complete()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-@>"] = cmp.mapping.complete(),
			}),
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },

				{ name = "path" },
				{ name = "buffer" },
				{ name = "nvim_lua" },
			},
		})

		cmp.setup.cmdline("/", {
			sources = { { name = "buffer" } },
			mapping = cmp.mapping.preset.cmdline(),
		})
		cmp.setup.cmdline("?", {
			sources = { { name = "buffer" } },
			mapping = cmp.mapping.preset.cmdline(),
		})
		cmp.setup.cmdline(":", {
			sources = cmp.config.sources(
				{ { name = "path" } },
				{ { name = "cmdline", option = { ignore_cmds = { "Man", "!" } } } }
			),
			mapping = cmp.mapping.preset.cmdline(),
		})
	end,
}
