return {
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        cmd = { "CodeCompanion", "CodeCompanionToggle", "CodeCompanionActions" },
        keys = {
            { "<leader>ccc", "<cmd>CodeCompanionChat<cr>", desc = "Open Code Companion Chat" },
            { "<leader>cce", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Chat" },
            { "<leader>cca", "<cmd>CodeCompanionActions<cr>", desc = "Code Companion Actions" },
        },
        opts = {
            adapters = {
                anthropic = function()
                    return require("codecompanion.adapters").extend("anthropic", {
                        schema = {
                            model = {
                                default = "claude-sonnet-4-20250514", -- Pour Claude Sonnet 4
                            },
                        },
                    })
                end,
            },
            strategies = {
                chat = {
                    adapter = "anthropic",
                },
                inline = {
                    adapter = "anthropic",
                },
            },
            prompt_library = require("plugins.code_companion.prompts"),
        },
    },
    {
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
    },
}
