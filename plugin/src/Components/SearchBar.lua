local Ani = script:FindFirstAncestor("Ani")

--< Modules >--
local Roact = require(Ani.Roact)
local Assets = require(Ani.Plugin.Assets)
local Theme = require(Ani.Plugin.Components.Theme)

--< Variables >--
local e = Roact.createElement

--< Component >--
local SearchBar = Roact.Component:extend("SearchBar")

function SearchBar:render()
    return Theme.with(function(theme)
        return e("Frame", {
            BackgroundColor3 = theme.Input;
            BorderSizePixel = 0;
            Position = self.props.Position;
            Size = self.props.Size;
        }, {
            Corner = e("UICorner", {
                CornerRadius = UDim.new(0, 3);
            });

            Search = e("ImageButton", {
                AnchorPoint = Vector2.new(1, 0);
                BackgroundTransparency = 1;
                Position = UDim2.new(1, -3, 0, 3);
                Size = UDim2.new(1, -5, 1, -6);
                SizeConstraint = Enum.SizeConstraint.RelativeYY;
                Image = Assets.Images.SearchButton;
                ImageColor3 = theme.SearchButton;
            });

            Input = e("TextBox", {
                BackgroundTransparency = 1;
                ClearTextOnFocus = false;
                Size = UDim2.new(1, -25, 1, 0);
                Font = theme.InputFont;
                PlaceholderColor3 = theme.PlaceholderText;
                PlaceholderText = "Search Assets";
                Text = "";
                TextColor3 = theme.InputText;
                TextSize = 14;
                TextXAlignment = Enum.TextXAlignment.Left;
            }, {
                Padding = e("UIPadding", {
                    PaddingLeft = UDim.new(0, 5);
                });
            });
        })
    end)
end

return SearchBar