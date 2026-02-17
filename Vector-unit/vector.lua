local vectorModule = {}

local vector = {x = 5, y = - 8}
local origin = {x = love.graphics.getWidth() / 2, y = love.graphics.getHeight() / 2}

local vectorFakeScaling = 25

function getMagnitudeFun()
  return math.sqrt(vector.x * vector.x + vector.y * vector.y)
end

function normalizeVector()
  local squaredMagnitude = vector.x * vector.x + vector.y * vector.y
  
  local magnitude = math.sqrt(squaredMagnitude)

  if magnitude == 0 then
    return
  end
  
  vector.x = vector.x / magnitude
  vector.y = vector.y / magnitude
  
  magnitude = magnitude / magnitude
  
  return magnitude
end

local getMagnitude = 0

function resetVector(x, y)
  vector.x = x
  vector.y = y
  local mag = getMagnitudeFun()
end

-- key n to normalize vector and v to get it back as before
function love.keypressed(key, scan, isrepeat)
  if key == "n" then
    getMagnitude = normalizeVector()
  end
  
  if key == "v" then
    resetVector(5, -8)
  end
end

  


function vectorModule.draw()
  love.graphics.line(origin.x, origin.y, vector.x * vectorFakeScaling + origin.x ,vector.y * vectorFakeScaling + origin.y)
  love.graphics.circle("line", vector.x * vectorFakeScaling + origin.x, vector.y * vectorFakeScaling + origin.y, 8)
  
  love.graphics.print("x : " .. vector.x .. "\n y : " .. vector.y .. "\n magnitude : " .. getMagnitudeFun(), 100, 100)
end

return vectorModule