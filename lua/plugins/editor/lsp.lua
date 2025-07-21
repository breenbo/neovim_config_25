return {
    {
        "mason-org/mason.nvim",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
            ensure_installed = {
                -- LSP servers (handled by mason-lspconfig, but included for completeness)
                "lua_ls",
                "bashls",
                "vtsls",
                "vue_ls",
                "tailwindcss",
                "html",
                "cssls",
                "jsonls",
                -- Formatters
                "stylua", -- Lua
                "prettierd", -- JS/TS/Vue/HTML/CSS/JSON/YAML/Markdown
                "shfmt", -- Shell
                -- Linters
                "shellcheck", -- Shell
                "eslint_d", -- JS/TS
                "luacheck", -- Lua
                "jsonlint",
            },
            auto_update = true,
            run_on_start = true,
        },
    },
    {
        -- Main LSP Configuration
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for Neovim
            -- Mason must be loaded before its dependents so we need to set it up here.
            -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
            { "mason-org/mason.nvim", opts = {} },
            "mason-org/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",

            -- Useful status updates for LSP.
            { "j-hui/fidget.nvim", opts = {} },

            -- Allows extra capabilities provided by blink.cmp
            "saghen/blink.cmp",
        },
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            -- vim.lsp.config("rust-analyzer", {
            --     capabilities = capabilities,
            --     cmd = { "rust-analyzer" }, -- Use system rust-analyzer
            --     filetypes = { "rust" },
            --     settings = {
            --         ["rust-analyzer"] = {
            --             cargo = {
            --                 allFeatures = true,
            --             },
            --             procMacro = {
            --                 enable = true,
            --             },
            --             diagnostics = {
            --                 enable = true,
            --             },
            --         },
            --     },
            -- })
            -- vim.lsp.enable("rust-analyzer")

            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
            })
            vim.lsp.enable("lua_ls")

            vim.lsp.config("bash_ls", {
                capabilities = capabilities,
            })
            vim.lsp.enable("bash_ls")
            vim.lsp.config("jsonls", {
                capabilities = capabilities,
            })
            vim.lsp.enable("jsonls")

            local vue_language_server_path = vim.fn.expand("$MASON/packages")
                .. "/vue-language-server"
                .. "/node_modules/@vue/language-server"

            local vue_plugin = {
                name = "@vue/typescript-plugin",
                location = vue_language_server_path,
                languages = { "vue" },
                configNamespace = "typescript",
            }
            local vtsls_config = {
                capabilities = capabilities,
                settings = {
                    vtsls = {
                        tsserver = {
                            globalPlugins = {
                                vue_plugin,
                            },
                        },
                    },
                },
                filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
            }

            local vue_ls_config = {
                capabilities = capabilities,
                init_options = {
                    typescript = {
                        serverPath = vim.fn.expand("$MASON/packages")
                            .. "/vue-language-server/node_modules/typescript/lib",
                    },
                },
                on_init = function(client)
                    client.handlers["tsserver/request"] = function(_, result, context)
                        local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
                        if #clients == 0 then
                            vim.notify(
                                "Could not find `vtsls` lsp client, `vue_ls` would not work without it.",
                                vim.log.levels.ERROR
                            )
                            return
                        end
                        local ts_client = clients[1]

                        local param = unpack(result)
                        local id, command, payload = unpack(param)
                        ts_client:exec_cmd({
                            title = "vue_request_forward",
                            command = "typescript.tsserverRequest",
                            arguments = {
                                command,
                                payload,
                            },
                        }, { bufnr = context.bufnr }, function(_, r)
                            local response_data = { { id, r.body } }
                            ---@diagnostic disable-next-line: param-type-mismatch
                            client:notify("tsserver/response", response_data)
                        end)
                    end
                end,
            }

            vim.lsp.config("vtsls", vtsls_config)
            vim.lsp.config("vue_ls", vue_ls_config)
            vim.lsp.config("tailwindcss", {})
            vim.lsp.enable({ "vtsls", "vue_ls", "tailwindcss" })

            -- nvim 0.11 or above
            vim.lsp.inlay_hint.enable(true)
            vim.diagnostic.config({
                -- virtual_lines = true,
                -- diagnostic with tiny inline diag
                virtual_text = false,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = true,
                },
                signs = {
                    numhl = {
                        [vim.diagnostic.severity.ERROR] = "ErrorMsg",
                        [vim.diagnostic.severity.WARN] = "WarningMsg",
                    },
                },
            })
        end,
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy", -- Or `LspAttach`
        priority = 1000, -- needs to be loaded in first
        config = function()
            require("tiny-inline-diagnostic").setup()
        end,
    },
}
