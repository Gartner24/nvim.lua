return {
    "nvim-lua/plenary.nvim",
    {"nvim-tree/nvim-web-devicons", opts = { default = true }},
    "tpope/vim-fugitive",
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("harpoon"):setup()
        end,
    },
    "folke/zen-mode.nvim",
    "mbbill/undotree",
    "laytan/cloak.nvim",
    { 'wakatime/vim-wakatime', lazy = false },
    "Eandrju/cellular-automaton.nvim",
}
