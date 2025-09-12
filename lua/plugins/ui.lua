return {
	{ "rose-pine/neovim", name = "rose-pine",
		config = function() vim.cmd.colorscheme("rose-pine") end
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
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "rmd", "mdx" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons", -- we already use devicons
      },
      opts = {
          completions = { lsp = { enabled = true } },
      },
    },

}
