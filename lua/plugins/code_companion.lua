return {
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
}
