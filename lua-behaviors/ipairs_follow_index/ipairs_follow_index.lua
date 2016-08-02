#!/bin/sh

_=[[
	[ -d results ] || mkdir results
	for beha in native ipairs51 ipairs52 ipairs53 ipairs53custom; do
		echo "# ------------------------------------- # $beha #"
		for lua in lua5.1 lua5.2 lua5.3 luajit-2.0 luajit-2.1; do
			echo "# follow $beha behavior on $lua"
			if ! command -v "$lua" >/dev/null 2>&-; then
				echo "- $lua not available"
				continue
			fi
			[ -d results/$beha ] || mkdir results/$beha
			"$lua" "$0" "$beha" > results/$beha/$lua.txt
		done
	done
	exit
]]

local ipairs = require"ipairs5x"[ assert(arg[1]) ]

a={"I@a","II@a",[7]="VII@a"}
local ipairsused = {"__ipairs-used"}
b=setmetatable({[3]="III@b"}, {__index=a})
c=setmetatable({[3]="III@c"}, {__index=function(_,k) return b[k] end})
d=setmetatable({[3]="III@d"}, {
	__index=function(_,k) return b[k] end,
	__ipairs=function(_,k) return next, ipairsused, nil end,
})
c2=setmetatable({}, {
	__index=c})

print("- a: (simple table with hole)")
for i,v in ipairs(a) do print(i,v) end

print("- b: (b ---> a)")
for i,v in ipairs(b) do print(i,v) end

print("- c: (c ---> b")
for i,v in ipairs(c) do print(i,v) end

print("- c2: (c2 ---> c)")
for i,v in ipairs(c2) do print(i,v) end

print("- d: (d -__index=f-> b ; d -__ipairs=f-> a)")
for i,v in ipairs(d) do print(i,v) end

