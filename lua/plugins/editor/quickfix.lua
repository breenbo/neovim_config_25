return {
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
