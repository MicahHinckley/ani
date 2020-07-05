local Ani = script:FindFirstAncestor("Ani")

--< Modules >--
local Roact = require(Ani.Roact)
local Theme = require(Ani.Plugin.Components.Theme)

--< Variables >--
local e = Roact.createElement

--< Component >--
local AssetBrowser = Roact.Component:extend("AssetBrowser")

function AssetBrowser:render()
    return Theme.with(function(theme)
        return 
    end)
end

return AssetBrowser