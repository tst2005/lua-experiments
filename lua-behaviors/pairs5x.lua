-- modified
-- original: http://lua-users.org/wiki/GeneralizedPairsAndIpairs
-- see also : http://lua-users.org/wiki/NextMetamethodForIndexTable

-- This discussion seems to pertain to Lua 5.1. In Lua 5.2, the __pairs and __ipairs metamethods were added. -- Anders Petersson 

local function pairs51(t) -- lua5.1 does NOT use mt.__pairs
	return next, t, nil
end

local function pairs53(t) -- lua5.2 and lua5.3 use mt.__pairs
	local mt = getmetatable(t)
	if mt and mt.__pairs then
		return mt.__pairs(t)
	end
	return next, t, nil
end

local pairs52 = pairs53

local M = {}

M.pairs51 = pairs51
M.pairs52 = pairs52
M.pairs53 = pairs53
M.native = _G.pairs

return M
