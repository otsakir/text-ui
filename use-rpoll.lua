local posix = require 'posix'
local fcntl = require 'posix.fcntl'
local stdio = require 'posix.stdio'

-- fd = fcntl.open ("/var/log/syslog", fcntl.O_RDONLY)

local fh = io.open("/var/log/syslog","r")
print(fh)

local fd = stdio.fileno(fh)
print('fd: '..fd)


io.read()
while true do
	s = fh:read()
	print(s)
	r = posix.rpoll (fd, 5000)
	print("r: "..r)
	io.read()
end


--[[
while true do
  r = posix.rpoll (fd, 5000)
  if r == 0 then
    print 'timeout'
  elseif r == 1 then
    print (fh:read ())
  else
    print "finish!"
    break
  end
end
]]--

fh:close()
