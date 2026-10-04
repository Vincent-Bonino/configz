-- For https://github.com/nvim-treesitter/nvim-treesitter
local ts = require('nvim-treesitter')

local languages = {
    'bash',
    'c_sharp',
    'diff',
    'json',
    'lua',
    'markdown',
    'markdown_inline',
    'nginx',
    'python',
    'requirements',
    'rust',
    'sql',
    'ssh_config',
    'toml',
    'yaml',
}

ts.install(languages)

-- Use treesitter features
vim.api.nvim_create_autocmd(
    'FileType',
    {
        pattern = languages,
        callback = function()
            vim.treesitter.start()
            -- vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            -- vim.wo[0][0].foldmethod = 'expr'
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
    }
)

