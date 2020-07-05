local Ani = script:FindFirstAncestor("Ani")

--< Modules >--
local Roact = require(Ani.Roact)

--< Themes >--
local Themes = {
    Light = {
        Primary = Color3.fromRGB(255, 255, 255);
    };

    Dark = {
        Primary = Color3.fromRGB(46, 46, 46);
    };
}

--< Vaiables >--
local Context = Roact.createContext(Themes.Light)
local Studio = nil

--< Functions >--
local function GetStudio()
	if Studio == nil then
		Studio = settings():GetService("Studio")
	end

	return Studio
end

--< Component >--
local ThemeProvider = Roact.Component:extend("ThemeProvider")

function ThemeProvider:updateTheme()
    self:setState({
        theme = Themes[GetStudio().Theme.Name] or Themes.Light
    })
end

function ThemeProvider:init()
	self:updateTheme()
end

function ThemeProvider:render()
	return Roact.createElement(Context.Provider, {
		value = self.state.theme,
	}, self.props[Roact.Children])
end

function ThemeProvider:didMount()
	self.Connection = GetStudio().ThemeChanged:Connect(function()
		self:updateTheme()
	end)
end

function ThemeProvider:willUnmount()
	self.Connection:Disconnect()
end

local function with(callback)
	return Roact.createElement(Context.Consumer, {
		render = callback,
	})
end

return {
	ThemeProvider = ThemeProvider,
	Consumer = Context.Consumer,
	with = with,
}