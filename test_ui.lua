require "lunit"

local ui = require "ui"
local io = require "io"
local inspect = require "inspect"

module( "test_ui", lunit.testcase )

function Side_new_test()
  local side = ui.Side:new(1,1,5,1)
  --io.write(inspect(side))
  assert_equal(1, side.x1)
  assert_equal(1, side.y1)
  assert_equal(5, side.x2)
  assert_equal(1, side.y2)
end

function Side_length_test()
  local side = ui.Side:new(1,1,5,1)
  assert_equal(4, side.length)
  side = ui.Side:new(5,1,5,10)
  assert_equal(9, side.length)
end

function Block_test()
  local block = ui.Block:new(2,2,5,1)
  assert_equal(5, block:getwidth())
  assert_equal(1, block:getheight())
  --io.write(inspect(block))
end

function test_success()
  assert_false( false, "This test never fails.")
end

--[[function test_failure()
  fail( "This test always fails!" )
end
]]