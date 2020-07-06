--< Modules >--
local Action = require(script:FindFirstAncestor("Action"))

--< Action >--
return Action(script.Name, function(assetId)
    return {
        AssetId = assetId;
    }
end)