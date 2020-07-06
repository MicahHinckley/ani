local Ani = script:FindFirstAncestor("Ani")

--< Modules >--
local Rodux = require(Ani.Rodux)

--< Variables >--
local Reducers = {}

--< Initialize >--
for _,descendant in ipairs(script:GetDescendants()) do
    if descendant:IsA("ModuleScript") then
        Reducers[descendant.Name] = require(descendant)
    end
end

--< Module >--
return Rodux.combineReducers(Reducers)