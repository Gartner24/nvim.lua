local env = require("utils.env")
local plugins = {
    require("plugins.core"),
    require("plugins.conform"),
    require("plugins.osc52"), -- VPS/SSH: copy to Windows clipboard via OSC52 (skipped in WSL)
    require("plugins.tree"),
    require("plugins.vimtex"),
    require("plugins.telescope"),
    require("plugins.treesitter"),
    require("plugins.lsp"),
    require("plugins.ui"),
    require("plugins.render_markdown"),
    require("plugins.trouble"),
    require("plugins.refactoring"),
    require("plugins.misc"),
    require("plugins.devicons"),
}
-- 99 AI agent: only load in WSL (opencode/claude CLIs; avoid errors on VPS)
if env.is_wsl() then
    table.insert(plugins, require("plugins.99"))
end
return plugins
