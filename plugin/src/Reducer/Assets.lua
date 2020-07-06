local Ani = script:FindFirstAncestor("Ani")

--< Modules >--
local Cryo = require(Ani.Cryo)

--< Actions >--
local AddAsset = require(Ani.Plugin.Action.AddAsset)
local UpdateAsset = require(Ani.Plugin.Action.UpdateAsset)
local RemoveAsset = require(Ani.Plugin.Action.RemoveAsset)

--< Reducer >--
local function AssetsReducer(state, action)
    state = state or {}

    if action.type == AddAsset.Name then
        return Cryo.Dictionary.join(state, {
            [action.AssetId] = {Name = action.Name; Path = action.Path};
        })
    elseif action.type == UpdateAsset.Name then
        if state[action.AssetId] then
            return Cryo.Dictionary.join(state, {
                [action.AssetId] = Cryo.Dictionary.join(state[action.AssetId], action.Data)
            })
        end
    elseif action.type == RemoveAsset.Name then
        return Cryo.Dictionary.join(state, {
            [action.AssetId] = Cryo.None;
        })
    end
    
    return state
end

return AssetsReducer