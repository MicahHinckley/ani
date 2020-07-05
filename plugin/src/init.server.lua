if not plugin then
    return
end

--< Modules >--
local Roact = require(script.Parent.Roact)

--< Components >--
local App = require(script.Components.App)
local Theme = require(script.Components.Theme)

--< Variables >--
local e = Roact.createElement

--< Start >--
local Application = e(Theme.ThemeProvider, nil, {
    AniUI = Roact.createElement(App, {
        plugin = plugin;
    });
})

local Tree = Roact.mount(Application, nil, "Ani UI")

plugin.Unloading:Connect(function()
    Roact.unmount(Tree)
end)