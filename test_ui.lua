require "lunit"

local ui = require "ui"
local io = require "io"
local inspect = require "inspect"

module( "test_ui", lunit.testcase )

io.write("asdfasdf")


function Block_test()
  local block = ui.Block:new({width=5,height=1})
  assert_equal(5, block:getwidth())
  assert_equal(1, block:getheight())
  --io.write(inspect(block))
end

function Area_new_test()
  local area = ui.Area:new({width=30, height=20})
  assert_equal(30, area.x1)
  assert_equal(0, area.x2)
  assert_equal(20, area.y1)
  assert_equal(0, area.y2)
  
end

function Area_placement_test()
  local area = ui.Area:new({width=30, height=20})
  local added_block = ui.Block:new({width=2, height=5})
  assert_false(area:block_overlaps(added_block, 10, 0))
  --io.write(inspect(area))
  --io.write(inspect(added_block))
  assert_false(area:block_overlaps(added_block, 10, -1))
  --area.block_overlaps
end

function test_success()
  assert_false( false, "This test never fails.")
end


--Area_new_test()
--Area_placement_test()

--[[function test_failure()
  fail( "This test always fails!" )
end
]]