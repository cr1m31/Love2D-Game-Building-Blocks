local vectorModule = {}

local vector = {x = 50, y = - 80}
local origin = {x = love.graphics.getWidth() / 2, y = love.graphics.getHeight() / 2}

local vectorFakeScaling = 120

function normalizeVector()
  local squaredMagnitude = vector.x * vector.x + vector.y * vector.y
  
  local magnitude = math.sqrt(squaredMagnitude)

  if magnitude == 0 then
    return
  end
  
  vector.x = vector.x / magnitude
  vector.y = vector.y / magnitude
  
  return magnitude
end

function vectorModule.draw()
  love.graphics.line(origin.x, origin.y, vector.x * vectorFakeScaling + origin.x ,vector.y * vectorFakeScaling + origin.y)
  love.graphics.circle("fill", vector.x * vectorFakeScaling + origin.x, vector.y * vectorFakeScaling + origin.y, 8)
  
  love.graphics.print("x : " .. vector.x .. "\n y : " .. vector.y .. "\n magnitude : " .. normalizeVector(), 100, 100)
end

return vectorModule