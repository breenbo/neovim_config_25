return {
    "milanglacier/minuet-ai.nvim",
    config = function()
        require("minuet").setup({
            -- Your configuration options here
            provider = "codestral",
            virtualtext = {
                auto_trigger_ft = { "lua", "javascript", "typescript", "rust", "vue", "bash" },
                keymap = {
                    accept = "<C-a>", -- accept whole completion
                    accept_line = "<C-l>", -- Accept one line
                    next = "<C-j>", -- next completion
                    dismiss = "<C-e>",
                },
            },
        })
    end,
}
