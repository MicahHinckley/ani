--< Module >--
local function Action(name, fn)
    return setmetatable({
        Name = name;
    }, {
        __call = function(self, ...)
            local Result = fn(...)

            Result.type = name

            return Result
        end
    })
end

return Action