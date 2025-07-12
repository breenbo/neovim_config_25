return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            -- telescope settings
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<C-p>", builtin.find_files, {})
            -- vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({
                            -- even more opts
                        }),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "echasnovski/mini.icons" },
        opts = function()
            local keymap = require("fzf-lua").config.defaults.keymap
            -- send resutls to quickfix
            keymap.fzf["ctrl-q"] = "select-all+accept"
            keymap.fzf["ctrl-u"] = "half-page-up"
            keymap.fzf["ctrl-d"] = "half-page-down"
        end,
        keys = {
            {
                "<leader>fb",
                function()
                    require("fzf-lua").buffers()
                end,
                desc = "Find buffers",
            },
            { "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
            { "<leader>fD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
            {
                "<leader>ff",
                function()
                    require("fzf-lua").files()
                end,
                desc = "Find Files in working directory",
            },
            {
                "<leader>fg",
                function()
                    require("fzf-lua").live_grep()
                end,
                desc = "Grep in working directory",
            },
            {
                "<leader>fk",
                function()
                    require("fzf-lua").keymaps()
                end,
                desc = "Find Keymaps",
            },
            { "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "Old files" },
            {
                "<leader>fr",
                function()
                    require("fzf-lua").resume()
                end,
                desc = "Find resume",
            },
            {
                "<leader>fw",
                function()
                    require("fzf-lua").grep_cword()
                end,
                desc = "Find Word in working directory",
            },
            {
                "<leader>fz",
                function()
                    require("fzf-lua").builtin()
                end,
                desc = "Find builtin fuzzy finder",
            },
            {
                "<leader>,",
                function()
                    require("fzf-lua").buffers()
                end,
                desc = "Switch Buffer",
            },
            {
                "<leader>/",
                function()
                    require("fzf-lua").lgrep_curbuf()
                end,
                desc = "Find in current buffer",
            },
        },
    },
}
