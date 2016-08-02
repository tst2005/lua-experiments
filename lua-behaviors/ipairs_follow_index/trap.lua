local good = {"I", "II"}
local bad= {"x", "xx"}
local test = setmetatable({}, {
	__index=good,
	__ipairs=function(t) return ipairs(bad) end,
})

for i,v in ipairs(test) do print(i,v) end
