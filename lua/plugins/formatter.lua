return {
    "stevearc/conform.nvim",

    -- no need to call something outside the config
    -- install the formatter into the lsp_config file
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            rust = { "rustfmt" },
            -- Conform will run the first available formatter
            javascript = { "prettierd", "prettier", stop_after_first = true },
            typescript = { "prettierd", "prettier", stop_after_first = true },
        },
        -- go to fallback on lsp format after timeout
        format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback",
        },
    },
    -- keys = {
    --     {
    --         "<leader>pf",
    --         function()
    --             require("conform").format({ async = true, lsp_format = "fallback" })
    --         end,
    --         mode = "",
    --         desc = "[P]retty [F]ormat",
    --     },
    -- },
}
