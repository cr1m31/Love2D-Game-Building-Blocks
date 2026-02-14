local vectorModule = {}

local vector = {x = 50, y = - 150, radius = 8}
local origin = {x = love.graphics.getWidth() / 2, y = love.graphics.getHeight() / 2}

local vectorFakeScaling = 120

function normalizeVector()
  local squaredMagnitude = vector.x * vector.x + vector.y * vector.y
  
  local magnitude = math.sqrt(squaredMagnitude)
  
  print(magnitude)
  
  if magnitude == 0 then
    return
  end
  
  vector.x = vector.x / magnitude * vectorFakeScaling
  vector.y = vector.y / magnitude * vectorFakeScaling
  
  magnitude = magnitude / magnitude * vectorFakeScaling
  return magnitude
end
normalizeVector()

function vectorModule.draw()
  love.graphics.line(origin.x, origin.y, vector.x + origin.x, vector.y + origin.y)
  love.graphics.circle("fill", vector.x + origin.x, vector.y + origin.y, vector.radius)
  
  love.graphics.print("x : " .. vector.x / normalizeVector() .. "\n y : " .. vector.y / normalizeVector() .. "\n magnitude : " .. normalizeVector() / vectorFakeScaling, 100, 100)
end

return vectorModule