return {
    {
        "mason-org/mason.nvim",
        opts = {},
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "lua_ls",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        keys = {
            { "gd", vim.lsp.buf.definition, desc = "Go to definition" },
            {
                "<leader>ca",
                vim.lsp.buf.code_acion,
                desc = "Code action",
            },
        },
        init = function()
            -- lsp completion
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- enable lua lsp
            vim.lsp.enable("lua_ls")
            vim.lsp.config("lua_ls", {
                settings = {
                    capabilities = capabilities,
                },
            })
        end,
    },
}
