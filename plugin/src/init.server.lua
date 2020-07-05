if not plugin then
    return
end

--< Modules >--
local Roact = require(script.Parent.Roact)

--< Components >--
local App = require(script.Components.App)

--< Start >--
local Application = Roact.createElement(App, {
    plugin = plugin;
})

local Tree = Roact.mount(Application, nil, "Ani UI")

plugin.Unloading:Connect(function()
    Roact.unmount(Tree)
end)