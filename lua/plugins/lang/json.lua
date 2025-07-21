return {
    "phelipetls/jsonpath.nvim",
    keys = {
        {
            "<leader>yp",
            function()
                vim.fn.setreg("+", require("jsonpath").get())
            end,
            desc = "copy json path",
        },
    },
    ft = { "json" },
}
