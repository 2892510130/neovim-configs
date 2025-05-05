return {
    "folke/tokyonight.nvim",
    opts = {
    },
    config = function (_, opts)
        require("tokyonight").setup(opts)
        vim.cmd("colorscheme tokyonight")
    end
}
