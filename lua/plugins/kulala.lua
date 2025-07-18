return {
    "mistweaverco/kulala.nvim",
    keys = {
        {
            "<leader>ks",
            function()
                require("kulala").run()
            end,
            desc = "Send request",
        },
        { "<leader>ka", desc = "Send all requests" },
        { "<leader>kb", desc = "Open scratchpad" },
    },
    ft = { "http", "rest" },
    opts = {
        global_keymaps = false,
        global_keymaps_prefix = "<leader>K",
        kulala_keymaps_prefix = "",
    },
}
