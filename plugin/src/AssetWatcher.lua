local Ani = script:FindFirstAncestor("Ani")

--< Services >--
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

--< Actions >--
local AddAsset = require(Ani.Plugin.Action.AddAsset)
local UpdateAsset = require(Ani.Plugin.Action.UpdateAsset)
local RemoveAsset = require(Ani.Plugin.Action.RemoveAsset)

--< Constants >--
local UNIQUE_ID_PREFIX = "AniId "
local LOOKUP = {game:GetService("ReplicatedFirst"), game:GetService("ReplicatedStorage")}

--< Module >--
local AssetWatcher = {}
AssetWatcher.__index = AssetWatcher

function AssetWatcher.new(store)
    local self = setmetatable({}, AssetWatcher)
    
    self.Store = store
    self.AncestryChangedConnections = {}
    self.NameChangedConnections = {}
    self.DescendantAddedConnections = {}

    return self
end

function AssetWatcher:GetAssetId(asset)
    for _,tag in ipairs(CollectionService:GetTags(asset)) do
        if string.find(tag, UNIQUE_ID_PREFIX) then
            return tag
        end
    end
end

function AssetWatcher:GenerateAssetId(assets)
    local AssetId = UNIQUE_ID_PREFIX .. HttpService:GenerateGUID()

    while assets[AssetId] do
        AssetId = UNIQUE_ID_PREFIX .. HttpService:GenerateGUID()
    end

    return AssetId
end

function AssetWatcher:IsAssetInLookup(asset)      
    for _,location in ipairs(LOOKUP) do
        if asset:IsDescendantOf(location) then
            return true
        end
    end

    return false
end

function AssetWatcher:Watch()
    local function DestroyAsset(assetId, instance)
        self.NameChangedConnections[instance]:Disconnect()
        self.NameChangedConnections[instance] = nil

        self.AncestryChangedConnections[instance]:Disconnect()
        self.AncestryChangedConnections[instance]= nil

        self.Store:dispatch(RemoveAsset(assetId))
    end

    local function OnInstanceAdded(instance)
        local Assets = self.Store:getState().Assets
        local AssetId = self:GetAssetId(instance)

        if AssetId and Assets[AssetId] then
            -- Assign asset a new id if it is a duplicate
            if CollectionService:GetTagged(AssetId)[1] ~= instance then
                CollectionService:RemoveTag(instance, AssetId)
                OnInstanceAdded(instance)
            end

            return
        end

        AssetId = AssetId or self:GenerateAssetId(Assets)

        self.NameChangedConnections[instance] = instance:GetPropertyChangedSignal("Name"):Connect(function()
            self.Store:dispatch(UpdateAsset(AssetId, {Name = instance.Name; Path = instance:GetFullName()}))
        end)

        self.AncestryChangedConnections[instance] = instance.AncestryChanged:Connect(function(_, parent)
            if parent then
                if self:IsAssetInLookup(instance) then
                    -- Update the asset's path when it moves
                    self.Store:dispatch(UpdateAsset(AssetId, {Path = instance:GetFullName()}))
                else
                    -- Destroy asset when it gets moved outside of LOOKUP
                    DestroyAsset(AssetId, instance)
                end
            else
                -- Destroy asset when it gets destroyed
                DestroyAsset(AssetId, instance)
            end
        end)

        CollectionService:AddTag(instance, AssetId)

        self.Store:dispatch(AddAsset(AssetId, instance.Name, instance:GetFullName()))
    end

    for _,location in ipairs(LOOKUP) do
        self.DescendantAddedConnections[location] = location.DescendantAdded:Connect(function(descendant)
            if descendant:IsA("Animation") then
                OnInstanceAdded(descendant)
            end
        end)
    end

    for _,location in ipairs(LOOKUP) do
        for _,descendant in ipairs(location:GetDescendants()) do
            if descendant:IsA("Animation") then
                OnInstanceAdded(descendant)
            end
        end
    end
end

function AssetWatcher:Stop()
    for _,connection in pairs(self.DescendantAddedConnections) do
        connection:Disconnect()
    end

    for _,connection in pairs(self.NameChangedConnections) do
        connection:Disconnect()
    end

    for _,connection in pairs(self.AncestryChangedConnections) do
        connection:Disconnect()
    end
end

function AssetWatcher:Destroy()
    self:Stop()
end

return AssetWatcher