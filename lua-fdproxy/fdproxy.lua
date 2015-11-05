local M = {}

require "mom"
local class = require "i".need "featured" "class"

local fdproxy = class("fdproxy", {init = function(self, fd) self.fd = fd end})

function fdproxy:read(a)
	local fd = self.fd
	return fd:read(a)
end

function fdproxy:write(a)
	local fd = self.fd
	return fd:write(a)
end

function fdproxy:close()
	return self.fd:close()
end

local function new(fd)
	return fdproxy:new(fd)
end

M.new = new

setmetatable(M, {__call = function(_, ...) return new(...) end})
return M
