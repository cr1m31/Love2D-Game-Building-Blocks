local vectorModule = {}

local vector = {x = 4, y = - 3}
local origin = {x = love.graphics.getWidth() / 2, y = love.graphics.getHeight() / 2}

function normalizeVector()
  local magnitude = math.sqrt(vector.x * vector.x + vector.y * vector.y)
  local unitVector = {x = vector.x / magnitude, y = vector.y / magnitude}
  return magnitude, unitVector
end

local scaleFactor = 50
local unitVecOffset = 100
function vectorModule.draw()
  local mag, unit = normalizeVector()
  love.graphics.print("mag : " .. mag .. "\n" .. "vector.x : " .. vector.x .. "\n" .. "vector.y : " .. vector.y, 100, 100)
  love.graphics.print("new mag : " .. (mag / mag) .. "\n" .. "unit.x : " .. unit.x .. "\n" .. "unit.y : " .. unit.y, 200, 100)
  
  love.graphics.line(origin.x, origin.y, origin.x + vector.x * scaleFactor, origin.y + vector.y * scaleFactor)
  love.graphics.line(origin.x + unitVecOffset, origin.y, origin.x + unitVecOffset + unit.x * scaleFactor, origin.y + unitVecOffset + unit.y * scaleFactor)
end

return vectorModule