local Ani = script:FindFirstAncestor("Ani")

--< Modules >--
local Roact = require(Ani.Roact)

--< Component >--
local App = Roact.Component:extend("App")

function App:init()
    self.Connections = {}

    local Toolbar = self.props.plugin:CreateToolbar("Ani")

    self.ToggleButton = Toolbar:CreateButton("Ani", "Show or hide the Ani panel.", "")
    self.ToggleButton.ClickableWhenViewportHidden = true
    self.ToggleButton.Click:Connect(function()
        self.DockWidget.Enabled = not self.DockWidget.Enabled
    end)

    local WidgetInfo = DockWidgetPluginGuiInfo.new(
        Enum.InitialDockState.Float,
        false,
        false,
        360, 190,
        360, 190
    )

    self.DockWidget = self.props.plugin:CreateDockWidgetPluginGui("Ani", WidgetInfo)
	self.DockWidget.Name = "Ani"
	self.DockWidget.Title = "Ani"
	self.DockWidget.AutoLocalize = false
	self.DockWidget.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	self.Connections.OnDockWidgetEnabled = self.DockWidget:GetPropertyChangedSignal("Enabled"):Connect(function()
		self.ToggleButton:SetActive(self.DockWidget.Enabled)
	end)
end

function App:willUnmount()
    for _,connection in pairs(self.Connections) do
        connection:Disconnect()
    end
end

function App:render()
    
end

return App