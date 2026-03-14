return {
    "lervag/vimtex",
    ft = { "tex", "plaintex" },
    init = function()
        vim.g.tex_flavor = "latex"
        vim.g.vimtex_view_method = "general"
        vim.g.vimtex_view_enabled = 1
        vim.g.vimtex_view_automatic = 1
        vim.g.vimtex_compiler_method = "latexmk"
        vim.g.vimtex_compiler_latexmk = {
            options = { "-pdf", "-interaction=nonstopmode", "-synctex=1" },
        }
        vim.g.vimtex_view_general_viewer = [[/usr/bin/okular]]
        vim.g.vimtex_view_general_options = [[-reuse-instance -forward-search @tex @line @pdf]]
  end,
}
