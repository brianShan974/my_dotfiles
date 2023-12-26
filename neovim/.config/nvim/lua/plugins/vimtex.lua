vim.g.vimtex_view_method = "skim"
vim.g.vimtex_compiler_method = "latexmk"

vim.g.vimtex_compiler_latexmk = {
    continuous = 0
}

return {
    "lervag/vimtex",
    ft = "tex",
}
