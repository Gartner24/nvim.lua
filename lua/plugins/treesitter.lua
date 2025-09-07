return {
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "javascript", "typescript", "html", "css", "python", "astro" },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/playground",
}
