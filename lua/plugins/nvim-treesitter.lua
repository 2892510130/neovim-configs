return {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    main = "nvim-treesitter.configs",
    opts = {
        ensure_installed = {
            "lua", "toml", "c", "cpp"
        },
        highlight = { enable = true },
    }
}
