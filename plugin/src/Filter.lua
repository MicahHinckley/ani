--< Functions >--
local function LevenshteinRatio(str1, str2)
    if #str1 == 0 then return 1 end
    if #str2 == 0 then return 1 end

    local Matrix = {}
    local Len1 = #str1 + 1
    local Len2 = #str2 + 1

    for i = 1, Len2 do
        Matrix[i] = {i-1}
    end

    for j = 1, Len1 do
        Matrix[1][j] = j-1
    end

    for i = 2, Len2 do
		for j = 2, Len1 do
			if string.byte(str2, i-1) == string.byte(str1, j-1) then
				Matrix[i][j] = Matrix[i-1][j-1]
			else
				Matrix[i][j] = math.min(
					Matrix[i-1][j-1] + 1,	-- Substitution
					Matrix[i  ][j-1] + 1,	-- Insertion
					Matrix[i-1][j  ] + 1) 	-- Deletion
			end
		end
	end

	return ((#str1 + #str2) - Matrix[Len2][Len1]) / (#str1 + #str2)
end

--< Module >--
local function Filter(str, filter)
    str = string.lower(str)
    filter = string.lower(filter)

    local Ratio = LevenshteinRatio(filter, str)

    return string.find(str, filter) or Ratio >= 0.75, Ratio * 10
end

return Filter