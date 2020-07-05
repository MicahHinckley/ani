local Ani = script:FindFirstAncestor("Ani")

--< Modules >--
local Roact = require(Ani.Roact)

--< Themes >--
local Themes = {
    Light = {
		ButtonFont = Enum.Font.GothamSemibold;
		InputFont = Enum.Font.Code;
		TitleFont = Enum.Font.GothamBold;
		MainFont = Enum.Font.Gotham;

		PrimaryText = Color3.fromRGB(64, 64, 64);

		Primary = Color3.fromRGB(255, 255, 255);
		Secondary = Color3.fromRGB(233, 233, 233);

		TopBackgroundDark = Color3.fromRGB(211, 211, 211);
		BottomBackgroundDark = Color3.fromRGB(126, 126, 126);

		Border = Color3.fromRGB(170, 170, 170);
    };

    Dark = {
		ButtonFont = Enum.Font.GothamSemibold;
		InputFont = Enum.Font.Code;
		TitleFont = Enum.Font.GothamBold;
		MainFont = Enum.Font.Gotham;

		PrimaryText = Color3.fromRGB(235, 235, 235);

		Primary = Color3.fromRGB(46, 46, 46);
		Secondary = Color3.fromRGB(53, 53, 53);

		TopBackgroundDark = Color3.fromRGB(58, 58, 58);
		BottomBackgroundDark = Color3.fromRGB(18, 18, 18);

		Border = Color3.fromRGB(30, 30, 30);
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