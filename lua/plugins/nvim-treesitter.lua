return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup({
            ensure_installed = { "lua", "toml", "c", "cpp", "python" },
            auto_install = true,
        })

        -- 启用高亮和缩进
        vim.treesitter.start()

        -- LSP + Treesitter 增强
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- 使用 Treesitter 的文本对象
                vim.keymap.set("n", "af", function()
                    local node = vim.treesitter.get_node()
                    if node then
                        local start_row, _, end_row, _ = node:range()
                        vim.cmd("normal! " .. (end_row - start_row + 1) .. "V")
                    end
                end, { buffer = ev.buf, silent = true })
            end,
        })
    end
}

