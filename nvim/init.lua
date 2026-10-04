-- neovim configuration file

-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()


-- Meta options

-- Set to true if a Nerd Font is installed and selected in the terminal
vim.g.have_nerd_font = true


-- Plugins

local gh = function(repo) return 'https://github.com/' .. repo end

-- Update treesitter parsers when the package is updated
vim.api.nvim_create_autocmd(
    'PackChanged',
    {
        callback = function(event)
            local name, kind = event.data.spec.name, event.data.kind
            if name == 'nvim-treesitter' and kind == 'update' then
                if not event.data.active then vim.cdm.packadd('nvim-treesitter') end
            vim.cmd('TSUpdate')
            end
        end,
    }
)

-- Resources:
--   https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
-- Ideas
--   nvim-mini/mini.nvim
--   nvim-tree/nvim-tree.lua
vim.pack.add({
    { src = gh('MeanderingProgrammer/render-markdown.nvim') },
    { src = gh('NMAC427/guess-indent.nvim') },
    { src = gh('folke/todo-comments.nvim') },
    { src = gh('folke/which-key.nvim') },
    { src = gh('lewis6991/gitsigns.nvim') },
    { src = gh('norcalli/nvim-colorizer.lua') },
    { src = gh('numToStr/Comment.nvim') },
    { src = gh('nvim-lualine/lualine.nvim') },
    { src = gh('nvim-treesitter/nvim-treesitter') },
    { src = gh('windwp/nvim-autopairs') },
})

vim.print('Use \':packupdate\' to update installed packages')


-- Configuration

-- Split configuration
require('config.autocmd')
require('config.keymaps')
require('config.options')

-- Plugin configuration
require('plugins.autopairs')
require('plugins.colorizer')
require('plugins.comment')
require('plugins.gitsigns') -- TODO configure
require('plugins.guess-indent')
require('plugins.lualine')
require('plugins.render-markdown')
require('plugins.todo-comments')
require('plugins.treesitter')
require('plugins.which-key') -- TODO configure
