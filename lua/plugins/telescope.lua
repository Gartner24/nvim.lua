return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup({
      defaults = {
        file_ignore_patterns = {
          "venv", "env", "__pycache__", "%.pyc",
          "node_modules", "dist", "build"
        },
      },
      pickers = {
        find_files = {
          hidden = true,      -- show hidden files if not ignored
          follow = true,      -- follow symlinks

        },
      },
    })
  end,
}
