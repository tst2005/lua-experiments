local fdproxy = require "fdproxy"

local fd1 = io.open("/etc/passwd")
local fd1b = fdproxy(fd1)
print(fd1b:read("*l"))
fd1b:close()

print(fd1)
print(fd1b)
