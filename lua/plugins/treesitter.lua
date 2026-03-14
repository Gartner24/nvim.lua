return {
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.config").setup({
                ensure_installed = {
                    "lua", "javascript", "typescript", "html", "css",
                    "python", "astro", "templ", "markdown", "markdown_inline",
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    "nvim-treesitter/nvim-treesitter-context",
}
