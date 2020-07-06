--< Modules >--
local Action = require(script:FindFirstAncestor("Action"))

--< Action >--
return Action(script.Name, function(assetId, name, path)
    return {
        AssetId = assetId;
        Name = name;
        Path = path;
    }
end)