
local rawget, NATIVE_rawget = require"almostrawget".rawget, require"_G".rawget

local a = {"a"}
assert(a[1] == "a")

assert(rawget(a, 1) == "a")

local b = setmetatable({}, {__index=a})
assert(b[1] == "a")
assert(NATIVE_rawget(b, 1)==nil)
--print(rawget(b, 1), NATIVE_rawget(b, 1))

--local c = setmetatable({"c"}, {__index=a})
--print(rawget(c, 1), NATIVE_rawget(c, 1)) -- "c"

local d = setmetatable({}, {__index=function(t,k)
	return rawget(t, k)
end})
assert(rawget(d, 1) == NATIVE_rawget(d, 1))

local e = setmetatable({}, {__index=b})
assert(e[1] == rawget(e,1))
assert(NATIVE_rawget(e, 1) == nil)

