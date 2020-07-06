if not plugin then
    return
end

--< Modules >--
local Roact = require(script.Parent.Roact)
local Rodux = require(script.Parent.Rodux)
local RoactRodux = require(script.Parent.RoactRodux)
local Reducer = require(script.Reducer)
local AssetWatcher = require(script.AssetWatcher)

--< Components >--
local App = require(script.Components.App)
local Theme = require(script.Components.Theme)

--< Variables >--
local e = Roact.createElement

--< Start >--
local Store = Rodux.Store.new(Reducer)
AssetWatcher = AssetWatcher.new(Store)
AssetWatcher:Watch()

local Application = e(RoactRodux.StoreProvider, {
    store = Store;
}, {
    e(Theme.ThemeProvider, nil, {
        AniUI = e(App, {
            plugin = plugin;
        });
    })
})

local Tree = Roact.mount(Application, nil, "Ani UI")

plugin.Unloading:Connect(function()
    Roact.unmount(Tree)

    AssetWatcher:Destroy()
end)