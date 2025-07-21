return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            --treesitter config
            local config = require("nvim-treesitter.configs")
            config.setup({
                ensure_installed = {
                    "html",
                    "scss",
                    "lua",
                    "vue",
                    "javascript",
                    "json5",
                    "typescript",
                    "rust",
                    "typst",
                    "regex",
                },
                highlight = { enable = true },
                indent = { enable = true },
                injection = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<Enter>", -- set to `false` to disable one of the mappings
                        node_incremental = "<Enter>",
                        scope_incremental = false,
                        node_decremental = "<Backspace>",
                    },
                },
            })
        end,
    },
}
