-- This file is automatically loaded by init.lua

local util = require("util")

local function map(mode, lhs, rhs, opts)
    local keys = require("lazy.core.handler").handlers.keys
    ---@cast keys LazyKeysHandler
    -- do not create the keymap if a lazy keys handler exists
    if not keys.active[keys.parse({ lhs, mode = mode }).id] then
        opts = opts or {}
        opts.silent = opts.silent ~= false
        vim.keymap.set(mode, lhs, rhs, opts)
    end
end

-- Paste over currently selected text without yanking it
map("v", "p", '"_dP', { silent = true })

-- go to files
map("n", "<leader>go", "<cmd>e ~/.config/neovim/lua/config/options.lua<cr>", { desc = "Go to options config" })
map("n", "<leader>gk", "<cmd>e ~/.config/neovim/lua/config/keymaps.lua<cr>", { desc = "Go to keymaps config" })
map("n", "<leader>gs", function()
    require("luasnip.loaders").edit_snippet_files({})
end, { desc = "Go to luasnip config" })
map("n", "<leader>gp", function()
    require("neo-tree.command").execute({ toggle = true, dir = "~/.config/neovim/lua/plugins" })
end, { desc = "Go to plugins config" })
map(
    "n",
    "<leader>gl",
    "<cmd>Telescope file_browser path=~/.config/neovim/lua/plugins<cr>",
    { desc = "Go to lazyvim config" }
)

-- better movement
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "v", "o" }, "H", "^", { desc = "Use 'H' as '^'" })
map({ "n", "v", "o" }, "L", "$", { desc = "Use 'L' as '$'" })

-- move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- windows resize and split
-- map("n", "<Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
-- map("n", "<Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
-- map("n", "<Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
-- map("n", "<Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
vim.keymap.set("n", "<Up>", require("smart-splits").resize_up)
vim.keymap.set("n", "<Down>", require("smart-splits").resize_down)
vim.keymap.set("n", "<Left>", require("smart-splits").resize_left)
vim.keymap.set("n", "<Right>", require("smart-splits").resize_right)
map("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right" })

-- Buffers
map({ "n", "i" }, "<A-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<leader>k", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map({ "n", "i" }, "<A-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<leader>j", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
-- Delete window in `mini.bufremove`
map("n", "<leader>D", "<C-W>c", { desc = "Delete window" })

-- search
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
map({ "i", "v", "n", "s" }, "<C-S>", "<cmd>wa<cr><esc>", { desc = "Save all files" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
map("n", "<", "v<g")
map("n", ">", "v>g")

-- toggle options
-- ===
-- map("n", "<leader>uf", require("lazyvim.plugins.lsp.format").toggle, { desc = "Toggle format on Save" })
-- ===
map("n", "<leader>us", function()
    util.toggle("spell")
end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function()
    util.toggle("wrap")
end, { desc = "Toggle Word Wrap" })
map("n", "<leader>ud", util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function()
    util.toggle("conceallevel", false, { 0, conceallevel })
end, { desc = "Toggle Conceal" })

-- Others
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit all" })
map("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Force quit all" })
map("n", "<c-q>", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<c-Q>", "<cmd>q!<cr>", { desc = "Force quit" })
map("n", "<leader>L", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- Go to home screen, copied from AstroNvim
map(
    "n",
    "<leader>h",
    function()
        local wins = vim.api.nvim_tabpage_list_wins(0)
        if #wins > 1 and vim.api.nvim_get_option_value("filetype", { win = wins[1] }) == "neo-tree" then
            vim.fn.win_gotoid(wins[2]) -- go to non-neo-tree window to toggle alpha
        end
        require("alpha").start(false, require("alpha").default_config)
    end,
    { desc = "Go to home screen" }
)

-- Toggle comment, copied from AstroNvim
map("n", "<C-/>",
    function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
    { desc = "Toggle comment" }
)
map("v", "<C-/>",
    function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
    { desc = "Toggle comment" }
)

-- Toggle terminal
map("n", "<F7>", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle floating terminal" })
map("n", "<F8>", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Toggle horizontal terminal" })

-- Close buffers
map("n", "<leader>c", "<cmd>:BDelete this<cr>", { desc = "Close current buffer" })
map("n", "<leader>tc", "<cmd>:BDelete ", { desc = "Close chosen buffer" })
