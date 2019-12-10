local curses = require "curses"
local json = require 'json'
local log = require 'log'
local inspect = require "inspect"
local mymodule = {}

local windows = {}
local rootWindow
local layout


function mymodule.init()
	io.stderr:write("Initializing curses window manager\n")
	rootWindow = curses.initscr()
	return rootWindow;
end


-- guarantees: a layout module variable present with valid layout windows
function mymodule.loadlayout(filename)
	local f = io.open(filename,'rb')
	local content = f:read("*all")
	layout = json.decode(content)
	-- maybe do some validation of the windows structure here
	for _,anywin in pairs(layout.windows) do
        local inX0, inY0, inWidth, inHeight = 0, 0, anywin.width, anywin.height
        anywin.outercwin = curses.newwin(anywin.height, anywin.width, anywin.y0, anywin.x0)            
        if anywin.border ~= false then
            anywin.outercwin:border (curses.ACS_VLINE, curses.ACS_VLINE, curses.ACS_HLINE, curses.ACS_HLINE, curses.ACS_ULCORNER, curses.ACS_URCORNER, curses.ACS_LLCORNER, curses.ACS_LRCORNER)
            inX0, inY0, inWidth, inHeight = inX0+1, inY0+1, inWidth-2, inHeight-2
        end
        if type(anywin.prefixPad) == 'string' then -- TODO should be string and have a positive size
            anywin.outercwin:mvaddstr(inY0,inX0,anywin.prefixPad)
            local offset = string.len(anywin.prefixPad)
            inX0 = inX0 + offset
            inWidth = inWidth - offset
        end
        if anywin.outercwin then
            --[[log.info(inspect(anywin))
            log.info('inHeight '..inHeight)
            log.info('inWidth '..inWidth)
            log.info('inY0 '..inY0)
            log.info('inX0 '..inX0)]]--
            anywin.cwin = anywin.outercwin:derive(inHeight, inWidth, inY0, inX0) 
            anywin.outercwin:refresh()
        else
            anywin.cwin = anywin.outercwin
        end
        anywin.cwin:refresh()

--[[        
		anywin.cwin = curses.newwin(anywin.height, anywin.width, anywin.y0, anywin.x0)
        anywin.cwin:border (curses.ACS_VLINE, curses.ACS_VLINE, curses.ACS_HLINE, curses.ACS_HLINE, curses.ACS_ULCORNER, curses.ACS_URCORNER, curses.ACS_LLCORNER, curses.ACS_LRCORNER)
        anywin.cwin:mvaddstr(0,2,' '..anywin.name..' ')
        -- cwin2 is the actual inner window inside the border where we will output text
        anywin.cwin2 = anywin.cwin:derive(anywin.height-2, anywin.width-2, 1,1)          
		anywin.cwin:refresh()
        anywin.cwin2:refresh()
--]]--
        windows[anywin.name] = anywin
	end
end


function mymodule.shutdown()
	curses.endwin()
	io.stderr:write("Curses window manager shut down\n")
end

function mymodule.createWindow(name, title)
	if not title then 
		title = name 
	end
	io.stderr:write("creating window "..title..'('..name..')')
end

mymodule.windows = windows

return mymodule

