local this = {}

local math = require "math"

function this.createRootArea()

end


-- A r e a ---

Area = {}

-- p: {width=_, height=_}
function Area:new(p)
    local area = {}
    -- limits, but of 'internal', inverse fashion. Note, is shoudl use the same interface with Blocks i.e. x1,y1,x2,y2
    area.x1 = p.width
    area.y1 = p.height
    area.x2 = 0
    area.y2 = 0;
    area.children = {}
    
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
function Area:block_overlaps(block, x0,y0)
  -- calculate the new (potential) coordinates of the block inside the area
  local new_x1 = block.x1 + x0
  local new_y1 = block.y1 + y0
  local new_x2 = block.x2 + x0
  local new_y2 = block.y2 + y0
  
  nok_blocks = {}
  -- copy all children to nok one by one
  --table.insert(nok_blocks, self) -- put area too. It has x1,y1,x2,y2
  for i=1,#self.children do table.insert(nok_blocks, self.children[i]) end
    
  for i=1,#nok_blocks do
    if new_x1 >= nok_blocks[i].x2 then 
      nok_blocks[i] = nil 
    elseif new_y1 >= nok_blocks[i].y2 then 
      nok_blocks[i] = nil
    elseif new_x2 <= nok_blocks[i].x1 then 
      nok_blocks[i] = nil
    elseif new_y2 <= nok_blocks[i].y1 then 
      nok_blocks[i] = nil 
    end
  end
  
  -- if there are any blocks left in nok_blocks, we got an overlap
  return #nok_blocks > 0
end


--- B l o c k ---

Block = {}

function Block:new(p)
	local block = {}
  block.x1 = 0
  block.x2 = p.width
  block.y1 = 0
  block.y2 = p.height
  block.material = p.material -- fluid|rigid
  block.gravity = p.gravity
  -- block.fixed -- the block is fixed and won't fall or go anywhere
  -- block.gravity -- left|right|top|bottom|
    
  setmetatable(block, self)
  self.__index = self

	return block
end

function Block:getwidth() 
  return self.x2-self.x1
end

function Block:getheight()
  return self.y2-self.y1
end


-- public stuff
this.Block = Block
this.Area = Area

return this