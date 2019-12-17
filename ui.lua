local this = {}

local math = require "math"

function this.createRootArea()

end

-- B l o c k ---

Block = {}

function Block:new(x0,y0,width,height)
	local block = {}
	block.topSide = Side:new( x0, y0, x0+width, y0)
	block.rightSide = Side:new( x0+width, y0, x0+width, y0+height)
	block.bottomSide = Side:new( x0+width, y0+height, x0, y0+height)
	block.leftSide = Side:new( x0, y0+height, x0, y0)
  
  setmetatable(block, self)
  self.__index = self

	return block
end

function Block:getwidth() 
  return self.topSide.length
end

function Block:getheight()
  return self.leftSide.length
end

-- S i d e ---

Side = {} 

function Side:new(x1, y1, x2, y2)
  -- TODO make sure the following points realy form a horizontal of vertical line (x1=x2 or y1=y2)
	local side = {x1=x1, y1=y1, x2=x2, y2=y2}
  if x1 == x2 then
    side.length = math.abs(y2-y1)
  else
    side.length = math.abs(x2-x1)
  end
    
  setmetatable(side, self)
  self.__index = self
    
	return side
end


-- public stuff
this.Side = Side
this.Block = Block

return this