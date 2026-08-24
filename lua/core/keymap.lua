vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.keymap.set({"n", "i"}, "<C-z>", "<Cmd>undo<CR>", { silent = true })
vim.keymap.set({"n"}, "<leader>tg", "<Cmd>Telescope live_grep<CR>", { silent = true })
