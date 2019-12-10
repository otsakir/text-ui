-- configure logging
local log = require "log"
log.outfile = 'main.log'
log.level = "debug"
log.console = false

require"remdebug.engine"
remdebug.engine.start()


local wm = require "wm"
local inspect = require "inspect"

log.info('starting application')

local function process(command)
  log.debug('accepted command:',command)
  local _, _, name, trailing = string.find(command, "^(%w+)%s*(.*)$") -- _name_  of command and _trailing_ stuff
  wm.windows.main.cwin:addstr(string.format("%s\n", name))
  wm.windows.main.cwin:refresh()
end

local function main()

    local screen = wm.init()
    wm.loadlayout("layout.json")

    wm.windows.main.cwin:addstr('this is another text message')
    wm.windows.main.cwin:refresh()
    
    -- enter the command loop
    command = 'not quit'
    while command ~= 'quit' do
        wm.windows.comline.cwin:move(0,0)
        wm.windows.comline.cwin:clrtoeol()
        command = wm.windows.comline.cwin:getstr()
        process(command)
    end
    
    wm.shutdown()
    print(inspect(wm.windows))    
end

-- To display Lua errors, we must close curses to return to
-- normal terminal mode, and then write the error to stdout.
local function err (err)
  log.error('error')
  curses.endwin ()
  print "Caught an error:"
  print (debug.traceback (err, 2))
  os.exit (2)
end

xpcall (main, err)
