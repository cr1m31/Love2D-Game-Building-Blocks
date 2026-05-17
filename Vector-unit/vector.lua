local vectorModule = {}

local vector = {x = 4, y = -3}
local origin = {x = love.graphics.getWidth() / 2, y = love.graphics.getHeight() / 2}
local unitVector = {x = 0, y = 0}

local scalingFactor = 30
local xOffset = 100

function normalizeVector()
  local magnitude = math.sqrt(vector.x * vector.x + vector.y * vector.y)
  
  if magnitude == 0 then
    return
  end
  
  unitVector.x = vector.x / magnitude
  unitVector.y = vector.y / magnitude
  
  return magnitude
end

function vectorModule.load()
  unitVector.x = vector.x
  unitVector.y = vector.y
  
  normalizeVector()
end


function vectorModule.draw()
  love.graphics.line(origin.x, origin.y, origin.x + vector.x * scalingFactor, origin.y + vector.y * scalingFactor)
  love.graphics.line(origin.x + xOffset, origin.y, origin.x + xOffset + unitVector.x * scalingFactor, origin.y + unitVector.y * scalingFactor)
  love.graphics.print("mag: " .. normalizeVector() / normalizeVector(), 100, 100)
  love.graphics.print("x: " .. unitVector.x .. " y: " .. unitVector.y, 100, 140)
end


return vectorModule