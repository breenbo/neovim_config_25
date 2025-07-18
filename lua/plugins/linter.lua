return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")

        -- Configure linters by filetype
        lint.linters_by_ft = {
            -- Vue.js
            vue = { "eslint_d" },
            -- JavaScript
            javascript = { "eslint_d" },
            -- TypeScript
            typescript = { "eslint_d" },
            -- Rust
            rust = { "clippy" },
            -- Lua
            lua = { "luacheck" },
            -- Bash/Shell
            bash = { "shellcheck" },
            sh = { "shellcheck" },
            -- JSON
            json = { "jsonlint" },
        }

        -- Custom linter configurations
        lint.linters.luacheck.args = {
            "--globals",
            "vim",
            "--read-globals",
            "use",
            "--formatter",
            "plain",
            "--codes",
            "--ranges",
            "-",
        }

        -- Simplified eslint_d configuration (uses project's eslint config)
        lint.linters.eslint_d.args = {
            "--format",
            "json",
            "--stdin",
            "--stdin-filename",
            function()
                return vim.api.nvim_buf_get_name(0)
            end,
        }

        -- Function to fix eslint issues
        local function eslint_fix()
            local filetype = vim.bo.filetype
            if filetype == "javascript" or filetype == "typescript" or filetype == "vue" then
                local filename = vim.api.nvim_buf_get_name(0)
                if filename ~= "" then
                    vim.cmd("silent !eslint_d --fix " .. vim.fn.shellescape(filename))
                    vim.cmd("checktime") -- Reload the file
                end
            end
        end

        -- Create autocommands for linting
        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                -- Only lint if linter is available for the filetype
                local ft = vim.bo.filetype
                if lint.linters_by_ft[ft] then
                    lint.try_lint()
                end
            end,
        })

        -- Manual linting command
        vim.api.nvim_create_user_command("Lint", function()
            lint.try_lint()
        end, {})

        -- Manual fix command
        vim.api.nvim_create_user_command("LintFix", function()
            eslint_fix()
        end, {})

        -- Keymap for manual linting
        vim.keymap.set("n", "<leader>l", function()
            lint.try_lint()
        end, { desc = "Trigger linting for current file" })

        -- Keymap for manual fixing
        vim.keymap.set("n", "<leader>lf", function()
            eslint_fix()
        end, { desc = "Fix linting issues" })
    end,
}
