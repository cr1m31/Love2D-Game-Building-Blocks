local vectorModule = {}

local vector = {x = 0, y = 0}
local origin = {x = love.graphics.getWidth() / 2, y = love.graphics.getHeight() / 2}
local magnitude = 0

function initializeVector(x, y)
  vector.x = x
  vector.y = y
  magnitude = math.sqrt(vector.x * vector.x + vector.y * vector.y)
end

function normalizeVector()
  magnitude = math.sqrt(vector.x * vector.x + vector.y * vector.y)
  vector.x = vector.x / magnitude
  vector.y = vector.y / magnitude
  magnitude = magnitude / magnitude
end

function love.keypressed(key, scan, isrepeat)
  if key == "i" then
    initializeVector(3, 4)
  end 
  
  if key == "n" then
    normalizeVector()
  end
  
end

local scalingFactor = 30

function vectorModule.draw()
  love.graphics.circle("line", vector.x * scalingFactor + origin.x, vector.y * scalingFactor + origin.y, 8)
  love.graphics.circle("fill", origin.x, origin.y, 4)
  
  love.graphics.line(origin.x, origin.y, vector.x * scalingFactor + origin.x, vector.y * scalingFactor + origin.y)
  
  love.graphics.print("x : " .. vector.x .. "\n y : " .. vector.y .. "\n magnitude : " .. magnitude, 100, 100)
end


return vectorModule