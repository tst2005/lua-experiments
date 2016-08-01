local M = {}

require "mom"
local class = require "i".need "featured" "class"

local fdproxy = class("fdproxy", {
	init = function(self, fd)
		self.fd = fd
		self.rbuffer={"",	-- read buffer
			empty=true,	-- read buffer is empty
			pos=1,		-- read buffer cursor position
			ibs=nil,	-- read input  blocksize
			obs=nil,	-- read output blocksize
		}
		self.wbuffer={"", empty=true, pos=1, ibs=nil, obs=nil}
	end
})

function fdproxy:read(a)
	local fd = self.fd
	local buf = self.ibuffer
	if not buf.ibs then
		return fd:read(a)
	end
	if buf.empty then
		local partial = fd:read(buf.ibs)
		if not partial then -- eof
			return partial
		end
		buf[1] = buf[1]..partial
		buf.empty=false
		buf.pos=1
	end
	local block = buf[1]:sub(buf.pos, buf.obs and buf.pos+buf.obs or -1)
	--buf.pos
	return block
	--return fd:read(a)
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
--[[

- for a read request :
	read  request ---(r_ibs)---> [proxy] ---(r_obs)---> read  result
	write request ---(w_ibs)---> [proxy] ---(w_obs)---> write result


	if ibs == obs (proxy is like disabled)
		-> direct access

	if ibs < obs
		request (small) -> buffer is empty -> read (big) -> populate the buffer -> return from buffer
		request -> return from buffer
		request -> return from buffer
		request -> return from buffer
		...
		request : buffer empty or not suffisant, read (big), return from buffer
		request -> return from buffer
		...
		request -> buffer is empty -> read (big) -> got eof -> return eof

	issue: buffer not empty but not suffisant -> read -> got eof -> must return the buffer ...

	if ibs > obs
		request (big) -> buffer is empty -> N=big // obs +1 -> N x read(small) ->
		N smaple: big=3 small=2 -> need 2 small for 1 big request N= 3//2 +1 = 2

		n_times_needed = roundup( (input_bs-current_buffer_size)/output_bs )
]]--
