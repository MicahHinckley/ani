local Ani = script:FindFirstAncestor("Ani")

--< Modules >--
local Roact = require(Ani.Roact)
local Asset = require(Ani.Plugin.Components.Asset)
local Theme = require(Ani.Plugin.Components.Theme)

--< Variables >--
local e = Roact.createElement

--< Functions >--
local function Category(props)
    return e("Frame", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        BorderColor3 = props.BorderColor3;
        BorderMode = Enum.BorderMode.Inset;
        BorderSizePixel = 1;
        Position = props.Position;
        Size = props.Size;
        ClipsDescendants = true;
    }, {
        Gradient = e("UIGradient", {
            Color = ColorSequence.new(props.BottomBackground, props.TopBackground);
            Rotation = 270;
        });

        Title = e("TextLabel", {
            BackgroundTransparency = 1;
            Position = UDim2.fromOffset(2, 0);
            Size = UDim2.new(1, -2, 1, 0);
            ClipsDescendants = true;
            Font = props.Font;
            Text = props.Title;
            TextColor3 = props.TextColor3;
            TextSize = 18;
            TextXAlignment = Enum.TextXAlignment.Left;
        });
    })
end

--< Component >--
local AssetBrowser = Roact.Component:extend("AssetBrowser")

function AssetBrowser:render()
    local NameSize = 0.3
    local PathSize = 0.7

    local Assets = {}

    Assets.ListLayout = e("UIListLayout")

    for i = 1, 10 do
        Assets["Asset" .. i] = e(Asset, {
            NameSize = NameSize;
            PathSize = PathSize;
        })
    end

    return Theme.with(function(theme)
        return e("Frame", {
            AnchorPoint = self.props.AnchorPoint;
            BackgroundColor3 = theme.Secondary;
            BorderSizePixel = 0;
            Position = self.props.Position;
            Size = self.props.Size;
        }, {
            Corner = e("UICorner", {
                CornerRadius = UDim.new(0, 4);
            });

            Categories = e("Frame", {
                BackgroundTransparency = 1;
                Position = UDim2.new(0, 5, 0, 5);
                Size = UDim2.new(1, -10, 0, 20);
            }, {
                Name = e(Category, {
                    BottomBackground = theme.BottomBackgroundDark;
                    TopBackground = theme.TopBackgroundDark;
                    BorderColor3 = theme.Border;
                    Font = theme.TitleFont;
                    TextColor3 = theme.PrimaryText;
                    Size = UDim2.fromScale(NameSize, 1);
                    Title = "Name";
                });

                Path = e(Category, {
                    BottomBackground = theme.BottomBackgroundDark;
                    TopBackground = theme.TopBackgroundDark;
                    BorderColor3 = theme.Border;
                    Font = theme.TitleFont;
                    TextColor3 = theme.PrimaryText;
                    Position = UDim2.fromScale(NameSize, 0);
                    Size = UDim2.fromScale(PathSize, 1);
                    Title = "Path";
                });
            });

            Assets = e("Frame", {
                AnchorPoint = Vector2.new(0.5, 0);
                BackgroundTransparency = 1;
                Position = UDim2.new(0.5, 0, 0, 30);
                Size = UDim2.new(1, -10, 1, -35);
            }, Assets);
        })
    end)
end

return AssetBrowser