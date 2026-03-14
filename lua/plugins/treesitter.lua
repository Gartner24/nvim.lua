return {
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
        priority = 1000, -- load before refactoring/render-markdown that depend on it
        config = function()
            local ok, ts = pcall(require, "nvim-treesitter")
            if not ok or not ts then return end
            ts.setup({
                ensure_installed = {
                    "lua", "javascript", "typescript", "html", "css",
                    "python", "astro", "templ", "markdown", "markdown_inline",
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
    "nvim-treesitter/nvim-treesitter-context",
}
