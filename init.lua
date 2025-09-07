require("bootstrap")   -- installs/loads lazy.nvim

require("options")     -- ui, tabs, clipboard, etc.

require("keymaps")     -- global keymaps



local plugins = require("plugins") -- collects plugin specs

require("lazy").setup(plugins)
