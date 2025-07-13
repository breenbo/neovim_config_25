return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "helix",
        spec = {
            { "<leader>c", group = "Code" }, -- group
            { "<leader>f", group = "Find" }, -- group
            { "<leader>g", group = "Git" }, -- group
            { "<leader>s", group = "Search" }, -- group
            { "<leader>u", group = "Ui" }, -- group
        },
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Available in buffer",
        },
    },
}
