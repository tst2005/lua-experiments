
local NATIVE_rawget = _G.rawget

--[[ --naive implementation--
local sentinel
local _rawget = function(t, k)
	if sentinel then
		return NATIVE_rawget(t, k)
	end
	sentinel = true
	local v = t[k]
	sentinel = nil
	return v
end
]]--

local _LOOP_ = {} -- uniq unpredictive value
local sentinel = {}
local sub_rawget = function(t, k)
	if sentinel[t] then
		return _LOOP_
	end
	sentinel[t] = true
	local v = t[k]
	sentinel[t] = nil
	return v
end
local _rawget = function(t, k)
	local v = sub_rawget(t,k)
	if v == _LOOP_ then
		sentinel = {} -- ?
		return NATIVE_rawget(t, k)
	end
	return v
end


return {rawget=_rawget}
--[[
le principe est qu'il semble que rawget soit un peu trop utilisé sans vrai raison ... voir pl.*
dans une sandbox il est dangeureux de laisser acceder au rawget natif (ca facilite fortement les choses pour arriver a sortir de la sandbox)
l'idee est d'emuler rawget dans la sandbox, et ne faire reelement appel a rawget natif que si ca boucle, ce qui ne devrait pas se produire avec un rawget...
]]--
