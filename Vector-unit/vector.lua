local vectorModule = {}

local vector = {originX = love.graphics.getWidth() / 2, originY = love.graphics.getHeight() / 2, x = 100, y = 200, radius = 8}

function normalizeVector()
  local squaredMagnitude = vector.x * vector.x + vector.y * vector.y
  
  local magnitude = math.sqrt(squaredMagnitude)
  print(magnitude)
  --vector.x = vector.x / magnitude
  --vector.y = vector.y / magnitude
  
end

function vectorModule.update()
  -- vector.x = love.mouse.getX()
  -- vector.y = love.mouse.getY()
  
  normalizeVector()
end

function vectorModule.draw()
  love.graphics.line(vector.originX, vector.originY, vector.x, vector.y)
  love.graphics.circle("fill", vector.x, vector.y, vector.radius)
end

return vectorModule