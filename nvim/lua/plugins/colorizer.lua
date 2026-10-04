-- For https://github.com/norcalli/nvim-colorizer.lua
require('colorizer').setup(
    { '*' },
    {
        css = true,     -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true,  -- Enable all CSS *functions*: rgb_fn, hsl_fn
        hsl_fn = true,  -- CSS hsl() and hsla() functions
        names = false,  -- "Name" codes like Blue
        rgb_fn = true,  -- CSS rgb() and rgba() functions
        RGB = true,     -- #RGB hex codes
        RRGGBB = true,  -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
    }
)
