return {
    {
        "echasnovski/mini.pairs",
        version = "*",
        config = function()
            require("mini.pairs").setup()
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    },
    {
        "echasnovski/mini.statusline",
        version = false,
        opts = {},
    },
    {
        "kevinhwang91/nvim-bqf",
        event = "VeryLazy",
        dependencies = { "junegunn/fzf", "nvim-treesitter/nvim-treesitter" },
        opts = {
            filetype = "qf",
            auto_resize_height = true,
        },
    },
    {
        "stevearc/quicker.nvim",
        event = "FileType qf",
        opts = {},
    },
}
