return {
    "mason-org/mason.nvim",
    event = "VeryLazy",
    dependencies = {
        "neovim/nvim-lspconfig",
        "mason-org/mason-lspconfig.nvim",
        "saghen/blink.cmp",  -- 添加 blink.cmp 作为依赖，确保它在 LSP 之前加载
    },
    opts = {},

    config = function(_, opts)
        -- 1. 启动 Mason
        require("mason").setup(opts)

        -- 2. 定义需要安装的 LSP 服务器列表
        local servers = {
            ["lua-language-server"] = {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" }
                        }
                    }
                }
            },
            ["clangd"] = {},
            -- 你可以在这里添加更多 LSP，例如：
            -- ["typescript-language-server"] = {},
            -- ["rust-analyzer"] = {},
            -- ["pyright"] = {},
        }

        -- 3. 获取 mason-lspconfig 的映射
        local mason_lspconfig = require("mason-lspconfig")
        local mappings = require("mason-lspconfig.mappings")
        local package_to_lspconfig = mappings.get_mason_map().package_to_lspconfig

        -- 4. 获取 blink.cmp 的 capabilities
        local capabilities = require("blink.cmp").get_lsp_capabilities()

        -- 5. 遍历并配置每个 LSP（新写法）
        for mason_package, config in pairs(servers) do
            -- 获取对应的 lspconfig 服务器名称
            local lsp_name = package_to_lspconfig[mason_package]
            if not lsp_name then
                vim.notify("Unknown LSP: " .. mason_package, vim.log.levels.WARN)
                goto continue
            end

            -- 确保 Mason 已经安装了该包
            local registry = require("mason-registry")
            local success, pkg = pcall(registry.get_package, mason_package)
            if success and not pkg:is_installed() then
                pkg:install()
            end

            -- ⭐ 新写法：使用 vim.lsp.config
            config.capabilities = capabilities
            config.on_attach = function(client)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end

            -- 关键：用 vim.lsp.config 替代 require("lspconfig")[name].setup()
            vim.lsp.config[lsp_name] = config

            ::continue::
        end

        -- 6. ⭐ 启用所有已配置的 LSP（替代 LspStart）
        local enabled_servers = {}
        for mason_package, _ in pairs(servers) do
            local lsp_name = package_to_lspconfig[mason_package]
            if lsp_name then
                table.insert(enabled_servers, lsp_name)
            end
        end
        vim.lsp.enable(enabled_servers)

        -- 7. 配置诊断显示
        vim.diagnostic.config({
            virtual_text = true,
            update_in_insert = true,
        })
    end
}
