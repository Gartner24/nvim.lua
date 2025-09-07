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
		"hrsh7th/cmp-nvim-lua",
		"saadparwaiz1/cmp_luasnip",
		-- snippets
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local lsp = require("lsp-zero")

		lsp.preset("recommended")
		lsp.setup()


		require("mason").setup({})
		require("mason-lspconfig").setup({ handlers = { lsp.default_setup } })

		local cmp = require("cmp")
		cmp.setup({
			snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
			mapping = {
				["<C-y>"]			= cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-@>"]			= cmp.mapping.complete(), -- in case your terminal maps C-Space to NUL
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },

				{ name = "path" },
				{ name = "buffer" },
				{ name = "nvim_lua" },
			},
		})
	end,
}
