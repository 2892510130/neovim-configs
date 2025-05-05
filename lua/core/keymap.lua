vim.keymap.set("n", "<C-a>m", function ()
    print("test keymap")
end, { silent = true })

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set({"n", "i"}, "<C-z>", "<Cmd>undo<CR>", { silent = true })
