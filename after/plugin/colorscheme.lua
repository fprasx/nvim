-- Tokyonight
function TokyoNight(light)
    light = light or false
    if light then
        require('tokyonight').setup({
            style = "day",
            day_brightness = 0.3
        })
    else
        require('tokyonight').setup({
            -- transparent = "true"
        })
    end
    vim.cmd('colorscheme tokyonight')
end

-- Nord
function Nord()
    -- vim.g.nord_disable_background = true
    vim.g.nord_italic = false
    vim.g.nord_bold = false
    require('nord').set()
end

function Onedark(style)
    style = style or 'cool'
    require('onedark').setup {
        style = style
    }
    -- have to load it
    require('onedark').load()
end

-- The default colorscheme to apply
Onedark()
