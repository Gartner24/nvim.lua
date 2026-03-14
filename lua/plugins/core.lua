return {
    "nvim-lua/plenary.nvim",
    {"nvim-tree/nvim-web-devicons", opts = { default = true }},
    { "tpope/vim-fugitive", cmd = { "Git", "G" } },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>a", function() require("harpoon"):list():add() end, desc = "Harpoon add" },
            { "<leader>h", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon menu" },
            { "<A-1>", function() require("harpoon"):list():select(1) end, desc = "Harpoon 1" },
            { "<A-2>", function() require("harpoon"):list():select(2) end, desc = "Harpoon 2" },
            { "<A-3>", function() require("harpoon"):list():select(3) end, desc = "Harpoon 3" },
            { "<A-4>", function() require("harpoon"):list():select(4) end, desc = "Harpoon 4" },
            { "<leader>A", function() require("harpoon"):list():remove() end, desc = "Harpoon remove" },
            { "<leader>H", function() require("harpoon"):list():clear() end, desc = "Harpoon clear" },
        },
        config = function()
            require("harpoon"):setup()
        end,
    },
    { "folke/zen-mode.nvim", cmd = "ZenMode" },
    { "mbbill/undotree", cmd = "UndotreeToggle" },
    { "laytan/cloak.nvim", event = "BufRead" },
    { 'wakatime/vim-wakatime', lazy = false },
    { "Eandrju/cellular-automaton.nvim", cmd = "CellularAutomaton" },
}
