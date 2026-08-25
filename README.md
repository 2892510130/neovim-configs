## How to make clangd works?
- Install clangd and mason clangd lsp
- Add `set(CMAKE_EXPORT_COMPILE_COMMANDS ON)` to your Cmake file, and add this to your base folder, remember to change the path
    - ```
        CompileFlags:
            CompilationDatabase: "the path to the compile_commands.json"
    ```

## Keymap
- `<leader>` is space, which is set in core/keymap.lua
- bufferline
    - `<leader>bh`, prev page
    - `<leader>bl`, next page
    - `<leader>bp`, pick page using the first letter
    - `<leader>bd`, delete page
- lspsaga
    - ```
        { "<leader>lr", ":Lspsaga rename<CR>" },
        { "<leader>lc", ":Lspsaga code_action<CR>" },
        { "<leader>ld", ":Lspsaga goto_definition<CR>" },
        { "K",          ":Lspsaga hover_doc<CR>" },
        { "<leader>lR", ":Lspsaga finder<CR>" },
        { "<leader>ln", ":Lspsaga diagnostic_jump_next<CR>" },
        { "<leader>lp", ":Lspsaga diagnostic_jump_prev<CR>" },
    ```
- nvim-tree: `<leader>uf`, open the file browser
- telescope: `<leader>tg`, the search bar


## What are those plugins do?
- blink: auto complete
- bufferline: the page above when open multiple files
- grug-far: search and replace
- indent_blankline: a verticle line that make you see the indent easier
- lspsaga: better -> more pretty lsp (build on lsp) 
- lualine: change the bottom command line
- mason: setup the lsp
- none-ls: make prettier, stylua and more act like lsp
- nvim-autopairs: maker pairs auto, and you can write in between them
- nvim-surround: quickly add, modify and delete the surrounds like () and "" and more
- nvim-treesitter: highlight, fold, gramma
- nvim-tree: the file browser
- telescope: the search bar
- tokyonight: the color scheme

## What is LSP and Treesitter do?

| 场景 | LSP 的作用 | Treesitter 的作用 |
| :--- | :--- | :--- |
| 代码高亮 | ❌ 不参与 | ✅ 提供精准高亮 |
| 代码折叠 | ❌ 不参与 | ✅ 基于语法树折叠 |
| 跳转定义 | ✅ 提供位置信息 | ❌ 不参与 |
| 重命名变量 | ✅ 找出所有引用并修改 | ❌ 不参与 |
| 选中函数体 | ❌ 不参与 | ✅ 基于语法树选中 |
| LSP 的诊断信息展示 | ✅ 提供错误/警告位置 | ✅ 高亮显示错误行（颜色由 Treesitter 提供） |
| 补全候选 | ✅ 提供类型信息 | ✅ 可以用来过滤补全候选（如只显示变量） |
