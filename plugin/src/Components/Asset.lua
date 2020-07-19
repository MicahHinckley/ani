local Ani = script:FindFirstAncestor("Ani")

--< Modules >--
local Roact = require(Ani.Roact)
local Theme = require(Ani.Plugin.Components.Theme)

--< Variables >--
local e = Roact.createElement

--< Component >--
local Asset = Roact.Component:extend("Asset")

function Asset:render()
    return Theme.with(function(theme)
        return e("Frame", {
            BackgroundColor3 = theme.Secondary;
            BorderSizePixel = 0;
            LayoutOrder = self.props.LayoutOrder;
            Size = UDim2.new(1, 0, 0, 15);
        }, {
            Name = e("TextLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.fromScale(self.props.NameSize, 1);
                ClipsDescendants = true;
                Font = theme.ButtonFont;
                Text = self.props.Name;
                TextColor3 = theme.PrimaryText;
                TextSize = 15;
                TextXAlignment = Enum.TextXAlignment.Left;
            });

            Path = e("TextLabel", {
                BackgroundTransparency = 1;
                Position = UDim2.fromScale(self.props.NameSize, 0);
                Size = UDim2.fromScale(self.props.PathSize, 1);
                ClipsDescendants = true;
                Font = theme.ButtonFont;
                Text = self.props.Path;
                TextColor3 = theme.PrimaryText;
                TextSize = 15;
                TextXAlignment = Enum.TextXAlignment.Left;
            });
        })
    end)
end

return Asset