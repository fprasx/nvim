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

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function(_)
        if vim.bo.ft == "coq" then
            Nord()
            -- Reenable highlighting from Coqtail
            vim.cmd([[hi def CoqtailChecked guibg=#113311]])
        else
            OneDark()
        end
    end,
})
