--< Modules >--
local Action = require(script:FindFirstAncestor("Action"))

--< Action >--
return Action(script.Name, function(assetId, data)
    return {
        AssetId = assetId;
        Data = data;
    }
end)