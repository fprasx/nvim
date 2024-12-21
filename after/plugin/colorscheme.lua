-- Tokyonight
function TokyoNight(light)
    light = light or false
    if light then
        require("tokyonight").setup({
            style = "day",
            day_brightness = 0.3,
        })
    else
        require("tokyonight").setup({
            -- transparent = "true"
        })
    end
    vim.cmd("colorscheme tokyonight")
end

function Nord()
    require("nord").setup({})
    vim.cmd("colorscheme nord")
end

function OneDark(style)
    style = style or "cool"
    require("onedark").setup({
        style = style,
    })
    -- have to load it
    require("onedark").load()
end

-- The default colorscheme to apply
OneDark()
