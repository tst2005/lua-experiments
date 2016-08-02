-- modified
-- original: http://lua-users.org/wiki/GeneralizedPairsAndIpairs
-- see also : http://lua-users.org/wiki/NextMetamethodForIndexTable

-- This discussion seems to pertain to Lua 5.1. In Lua 5.2, the __pairs and __ipairs metamethods were added. -- Anders Petersson

local function is_not_callable(t)
	return not (getmetatable(t) or {}).__call
end

local function ipairs53custom(t, startvalue, callabletable) -- lua5.3 does NOT use mt.__ipairs
	local i = startvalue and type(startvalue)=="number" and startvalue-1 or 0
	local mt = getmetatable(t)
	local custom = mt and mt.__index
	if not custom then
		custom = function(_,k) return t[k] end
	else
		if type(custom)=="table" and (not callabletable or is_not_callable(custom)) then
			local c = custom
			custom = function(_,k) return c[k] end
		end
	end
	--local custom=custom
	return function()
		i = i + 1
		local v = custom(t,i)
		if v ~= nil then
			return i, v
		end
	end
end

local function ipairs53withstart(t, startvalue) -- lua5.3 like (does NOT use mt.__ipairs) but with start value support
	local i = startvalue and type(startvalue)=="number" and startvalue-1 or 0
	local mt = getmetatable(t)
	t = mt and type(mt.__index)=="table" and mt.__index or t
	return function()
		i = i + 1
		local v = t[i]
		if v ~= nil then
			return i, v
		end
	end
end

local function ipairs53(t) -- lua5.3 does NOT use mt.__ipairs
	local i = 0
	local mt = getmetatable(t)
	t = mt and type(mt.__index)=="table" and mt.__index or t
	return function()
		i = i + 1
		local v = t[i]
		if v ~= nil then
			return i, v
		end
	end
end

local function ipairs52(t) -- lua5.2 use mt.__ipairs
	local m = getmetatable(t)
	if m and m.__ipairs then
		return m.__ipairs(t)
	end
	return (function(t, var)
		var = var + 1
		local value = rawget(t,var)
		if value ~= nil then
			return var, value
		end
		return
	end), t, 0
end

local function ipairs51(t) -- lua5.1 does NOT use mt.__ipairs
	local i = 0
	--local mt = getmetatable(t)
	--t = mt and type(mt.__index)=="table" and mt.__index or t
	local tget = rawget --function(t,k) return t[k] end --rawget
	return function()
		i = i + 1
		local v = tget(t,i)
		if v ~= nil then
			return i, v
		end
	end
end


local M = {}

M.ipairs51 = ipairs51
M.ipairs52 = ipairs52
M.ipairs53 = ipairs53
M.ipairs53withstart = ipairs53withstart
M.ipairs53custom = ipairs53custom
M.native = _G.ipairs

return M
