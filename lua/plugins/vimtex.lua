return {
    "lervag/vimtex",
    lazy = false,
    init = function()
        vim.g.tex_flavor = "latex"
        vim.g.vimtex_view_method = "general"
        vim.g.vimtex_view_enabled = 1
        vim.g.vimtex_view_automatic = 1
        vim.g.vimtex_compiler_method = "latexmk"
        vim.g.vimtex_compiler_latexmk = {
            options = { "-pdf", "-interaction=nonstopmode", "-synctex=1" },
        }

        -- Adjust if SumatraPDF is installed elsewhere
        vim.g.vimtex_view_general_viewer = [[/mnt/c/Program Files/SumatraPDF/SumatraPDF.exe]]
        vim.g.vimtex_view_general_options = [[-reuse-instance -forward-search @tex @line @pdf]]
  end,
}
