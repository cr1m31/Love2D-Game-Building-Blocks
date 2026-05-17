local vectorModule = {}

local displayMod = require("display")

local vector = {x = 0, y = 0}
local origin = {x = love.graphics.getWidth() / 2, y = love.graphics.getHeight() / 2}
local magnitude = 0

function vectorModule.initializeVector(x, y)
  vector.x = x
  vector.y = y
  magnitude = math.sqrt(vector.x * vector.x + vector.y * vector.y)
end

function vectorModule.normalizeVector()
  magnitude = math.sqrt(vector.x * vector.x + vector.y * vector.y)
  
  -- prevent 0 division
  if magnitude == 0 then
    return
  end 
  
  vector.x = vector.x / magnitude
  vector.y = vector.y / magnitude
  magnitude = magnitude / magnitude
end

function vectorModule.draw()
  displayMod.draw(vector, origin, magnitude)
end

return vectorModule