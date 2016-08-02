-- modified
-- original: http://lua-users.org/wiki/GeneralizedPairsAndIpairs
-- see also : http://lua-users.org/wiki/NextMetamethodForIndexTable

-- This discussion seems to pertain to Lua 5.1. In Lua 5.2, the __pairs and __ipairs metamethods were added. -- Anders Petersson 

local function pairs51simple(t) -- lua5.1 does NOT use mt.__pairs
	return next, t, nil
end

local function pairs53simple(t) -- lua5.2 and lua5.3 use mt.__pairs
	local mt = getmetatable(t)
	if mt and mt.__pairs then
		return mt.__pairs(t)
	end
	return next, t, nil
end

local pairs52simple = pairs53simple

--- shadow iterator ---

-- use pairs, but never expose the table `t` or the function `next`
local function pairs51shadow(t)
	local function f(_, k)
		return next(t, k)
	end
	return f, "shadow", nil
end

-- same than shadow pairs, byt also deny the way to call the handler with other key value
-- each call return the next result
local function pairs51shadowest(t)
	local k
	local function f()
		local k2,v2 = next(t, k)
		k=k2
		return k2, v2
	end
	return f, "shadowest", nil
end

local function pairs53shadow(t)
	local mt = getmetatable(t)
	if mt and mt.__pairs then
		return mt.__pairs(t)
	end
	return pairs51shadow(t)
end
local function pairs53shadowest(t)
	local mt = getmetatable(t)
	if mt and mt.__pairs then
		return mt.__pairs(t)
	end
	return pairs51shadowest(t)
end

local pairs52shadow = pairs53shadow
local pairs52shadowest = pairs53shadowest

local M = {}

M.pairs51simple = pairs51simple
M.pairs52simple = pairs52simple
M.pairs53simple = pairs53simple

M.native = _G.pairs

M.pairs51shadow = pairs51shadow
M.pairs51shadowest = pairs51shadowest

M.pairs52shadow = pairs52shadow
M.pairs52shadowest = pairs52shadowest

M.pairs53shadow = pairs53shadow
M.pairs53shadowest = pairs53shadowest

return M
