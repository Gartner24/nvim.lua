return {
    "ThePrimeagen/99",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local _99 = require("99")
        _99.setup({
            provider = _99.OpenCodeProvider, -- or OpenCodeProvider, CursorAgentProvider
            completion = { source = "cmp" },
            md_files = { "AGENT.md" },
        })
        vim.keymap.set("v", "9v", function()
            _99.visual()
        end, { desc = "99: AI agent on visual selection" })
        vim.keymap.set("v", "9s", function()
            _99.stop_all_requests()
        end, { desc = "99: Stop all requests" })
    end,
}
