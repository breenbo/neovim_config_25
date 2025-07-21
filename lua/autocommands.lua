-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- help in vertical split
vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    callback = function()
        vim.bo.bufhidden = "unload"
        vim.cmd("wincmd L")
        vim.cmd("vertical resize 81")
    end,
})
