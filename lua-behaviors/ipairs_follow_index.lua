ipairs = require"ipairs5x"[arg[1]]

a={"I","II",[7]="s"}
b=setmetatable({[3]="III"}, {__index=a})
c=setmetatable({[3]="III"}, {__index=function(_,k) return b[k] end})
d=setmetatable({[3]="III"}, {
	__index=function(_,k) return b[k] end,
	__ipairs=function(_,k) return next, a, nil end,
})

print("A:")
for i,v in ipairs(a) do print(i,v) end

print("B:")
for i,v in ipairs(b) do print(i,v) end

print("C:")
for i,v in ipairs(c) do print(i,v) end

print("D:")
for i,v in ipairs(d) do print(i,v) end

