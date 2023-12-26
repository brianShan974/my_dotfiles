vim.cmd("syntax enable")

vim.g.vimtex_view_method = 'skim'
vim.g.vimtex_compiler_method = 'latexmk'

return {
    "lervag/vimtex",
    lazy = false,
}
