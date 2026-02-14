return {
	{ "erikbackman/brightburn.vim" },
	{ "folke/tokyonight.nvim", lazy = false },
	{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		config = function()
			require("gruvbox").setup({
				terminal_colors = true,
				undercurl = true,
				underline = false,
				bold = true,
				italic = { strings = false, emphasis = false, comments = false, operators = false, folds = false },
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true,
				contrast = "",
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = false,
			})
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		config = function()
			require("rose-pine").setup({
				disable_background = false,
				styles = { italic = false },
			})
			-- Dynamic colorscheme based on buffer filetype (ThePrimeagen pattern)
			vim.api.nvim_create_autocmd("BufEnter", {
				callback = function()
					if vim.bo.filetype == "zig" then
						pcall(vim.cmd.colorscheme, "tokyonight-night")
					else
						pcall(vim.cmd.colorscheme, "rose-pine-moon")
					end
				end,
			})
		end,
	},
	{ "nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = { theme = "auto", section_separators = "", component_separators = "" },
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		 end

	},
}
