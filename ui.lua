local this = {}

local math = require "math"

function this.createRootArea()

end


-- A r e a ---

Area = {}

--[[
	width
	height
	blocks: []
	place(Block)
		
	// each placed component registers its sides to the following arrays, sorted.
	topSides: []
	rightSides: []
	bottomSides: []
	leftSides: []
}]]



function Area:new(width, height)
    local area = {}
    -- define limits of the area
    area.topSide = Side:new(0,0, width, 0)
    area.rightSide = Side:new(width,0,height, width)
    area.bottomSide = Side:new(height, width, 0, height)
    area.leftSide = Side:new(0, height, 0, 0)
    -- areas keep track of all sides of contained blocks, plus their own side too. Ordered. 
    area.topSides = {area.bottomSide}
    area.rightSides = {area.leftSide}
    area.bottomSides = {area.topSide}
    area.leftSides = {area.rightSide}
    
    setmetatable(area, self)
    self.__index = self
    
    return area
end

-- position: for rigids, it's the position within the parent area of the top-left corner of block
function Area:place(block, position)
  if position ~= 'top-center' then error('only center position accepted for now') end
  if block.material ~= 'rigid' then error('only rigid materials accepted for now') end
  
  
end

-- is there anything already at x0 y0 ? Can the block be put there for a while ?
function Area:spaceAvailable(block, x0,y0)
  local topSide = block.topSide.offset(x0,y0)  -- calculate side's coords if placed inside Area at x0,y0
  local rightSide = block.rightSide.offset(x0,y0)
  local bottomSide = block.bottomSide.offset(x0,y0)
  local leftSide = block.leftSide.offset(x0,y0)
  -- we got the four sides in terms of area's coordinates. Let's see if it fits there
  
  
end



--- B l o c k ---

Block = {}

function Block:new(p)
	local block = {}
	block.topSide = Side:new( 0, 0, p.width, 0)
	block.rightSide = Side:new( p.width, 0, p.width, p.height)
	block.bottomSide = Side:new( p.width, p.height, 0, p.height)
	block.leftSide = Side:new( 0, p.height, 0, 0)
  block.material = p.material -- fluid|rigid
  block.gravity = p.gravity
  -- block.fixed -- the block is fixed and won't fall or go anywhere
  -- block.gravity -- left|right|top|bottom|
  
  
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

--- S i d e ---

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

function Side:offset(dx,dy)
  self.x1 = self.x1 + dx
  self.y1 = self.y1 + dy
  self.x2 = self.x2 + dx
  self.y2 = self.y2 + dx
end


-- public stuff
this.Side = Side
this.Block = Block

return this