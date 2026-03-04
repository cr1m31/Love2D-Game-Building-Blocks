local vectorModule = {}

local vector = {x = 4, y = 3}
local unitVector = {x = 0, y = 0}
local origin = {x = love.graphics.getWidth() / 2, y = love.graphics.getHeight() / 2}

function calculateMagnitude()
  local magnitude = math.sqrt(vector.x * vector.x + vector.y * vector.y)
  return magnitude
end

function normalizeVector()
  local processedMagnitude = calculateMagnitude()
  unitVector.x = unitVector.x / processedMagnitude
  unitVector.y = unitVector.y / processedMagnitude
  
  local normalizedMagnitude = processedMagnitude / processedMagnitude
  
  return normalizedMagnitude
end

local vectorScaling = 20
function vectorModule.draw()
  love.graphics.print("magnitude : " .. calculateMagnitude(), 200, 200)
  
  love.graphics.print("normalized magnitude : " .. normalizeVector(), 200, 250 )
  love.graphics.setColor(1,1,1)
  love.graphics.line(origin.x, origin.y,vectorScaling * vector.x + origin.x,vectorScaling * vector.y + origin.y)
  love.graphics.setColor(1,0,0)
  love.graphics.line(origin.x - 80, origin.y - 80 ,unitVector.x * vectorScaling + origin.x + 80, unitVector.y * vectorScaling + origin.y + 75)
  love.graphics.setColor(1,1,1)
  love.graphics.circle("line", origin.x, origin.y, 10)
end

return vectorModule