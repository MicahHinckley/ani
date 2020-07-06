--< Services >--
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

--< Constants >--
local UNIQUE_ID_PREFIX = "AniId "
local LOOKUP = {game:GetService("ReplicatedFirst"), game:GetService("ReplicatedStorage")}

--< Functions >--
local function GetUniqueAniId(instance)
    for _,tag in ipairs(CollectionService:GetTags(instance)) do
        if string.find(tag, UNIQUE_ID_PREFIX) then
            return tag
        end
    end
end

--< Module >--
local function FindAssets()
    local Assets = {}

    for _,location in ipairs(LOOKUP) do
        for _,descendant in ipairs(location:GetDescendants()) do
            if descendant:IsA("Animation") then
                local Tag = GetUniqueAniId(descendant) or UNIQUE_ID_PREFIX .. HttpService:GenerateGUID()
                
                Assets[Tag] = {Name = descendant.Name, Path = descendant:GetFullName()}
            end
        end
    end

    return Assets
end

return FindAssets