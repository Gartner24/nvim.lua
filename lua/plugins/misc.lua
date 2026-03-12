return {
	{ "laytan/cloak.nvim", config = function()
			require("cloak").setup({
				enabled = true, cloak_character = "*", highlight_group = "Comment",
				patterns = { { file_pattern = { ".env*", "wrangler.toml", ".dev.vars" }, cloak_pattern = "=.+" } },
			})
		end
	},
	"mbbill/undotree",
	-- Indent guides: vertical lines at each indent level
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("ibl").setup({
				indent = { char = "│" },
				scope = { enabled = true, show_start = false, show_end = false },
			})
		end,
	},
}
