vim.g.mapleader = " "
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

vim.opt.clipboard = "unnamedplus"

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.showmode = false
vim.opt.exrc = true
vim.o.winborder = "rounded"

vim.opt.relativenumber = true
vim.opt.signcolumn = "auto"

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll half page down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll half page up and center" })
vim.keymap.set("n", "<leader>u", ":e!<CR>", { desc = "Reload file from disk" })
vim.keymap.set("n", "<A-z>", ":set wrap!<CR>", { desc = "Toggle line wrap" })

vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

vim.keymap.set("n", "<leader>w", "<C-w>")
vim.keymap.set("n", "<leader>w<CR>", ":term<CR>", { desc = "Open terminal" })
vim.keymap.set("n", "<leader>wm", ":WinShift<CR>", { desc = "Move windows" })

vim.keymap.set("n", "<Tab><Tab>", ">>", { desc = "Indent line" })
vim.keymap.set("v", "<Tab><Tab>", ">", { desc = "Indent selection" })
vim.keymap.set("n", "<S-Tab><S-Tab>", "<<", { desc = "Outdent line" })
vim.keymap.set("v", "<S-Tab><S-Tab>", "<", { desc = "Outdent selection" })

vim.keymap.set(
    "n",
    "<Up>",
    "v:count == 0 ? 'gk' : 'k'",
    { expr = true, silent = true, desc = "Move up (linewise with count)" }
)
vim.keymap.set(
    "n",
    "<Down>",
    "v:count == 0 ? 'gj' : 'j'",
    { expr = true, silent = true, desc = "Move down (linewise with count)" }
)

vim.keymap.set("n", "´", "`", { desc = "Go to mark" })
vim.keymap.set("x", "p", "P", { desc = "Paste without overwriting register" })

vim.keymap.set("n", "M", function()
    local mark = vim.fn.nr2char(vim.fn.getchar())
    if mark:match("%a") then
        vim.cmd("delmark " .. mark)
    else
        print("Invalid mark. Please use a letter (a-z, A-Z).")
    end
end, { desc = "Delete mark" })

if vim.fn.has("win32") == 1 then
    vim.cmd("language en_US")
end

vim.keymap.set("n", "<leader>r", function()
    local path = vim.fn.expand("%:p:h")
    if path == "" then
        path = vim.fn.getcwd()
    end

    vim.ui.open(path)
end, { desc = "Open file manager" })

local general_augroup = vim.api.nvim_create_augroup("user_general", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = general_augroup,
    pattern = "hyprlang",
    callback = function(event)
        vim.bo[event.buf].commentstring = "# %s"
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = general_augroup,
    pattern = { "markdown", "tex" },
    callback = function()
        vim.opt_local.wrap = true
    end,
})
