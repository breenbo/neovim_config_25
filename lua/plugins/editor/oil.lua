return {
    {
        "stevearc/oil.nvim",
        ---@module 'oil'
        keys = {
            { "-", ":Oil --float<CR>", desc = "Open Oil file explorer" },
        },
        opts = {},
        -- Optional dependencies
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
    },
}
