return {
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "javascript", "typescript", "html", "css", "python", "astro", "templ" },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/playground",
    ensure_installed = {
        "lua","javascript","typescript","html","css","python","astro","templ",
        "markdown","markdown_inline",
    },
}
