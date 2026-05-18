local vectorModule = {}

local origin = {x = love.graphics.getWidth() / 2, y = love.graphics.getHeight() / 2}
local vector = {x = 4, y = - 3}
local unitVector = {x = 0, y = 0}

local xOffset = 100
local scaleVec = 50

function normalizeVector()
  local magnitude = math.sqrt(vector.x * vector.x + vector.y * vector.y)
  unitVector.x = vector.x / magnitude
  unitVector.y = vector.y / magnitude
  local newMagnitude = magnitude / magnitude
  return newMagnitude
end

local newMag = 0
function vectorModule.init()
  unitVector.x = vector.x
  unitVector.y = vector.y
  
  newMag = normalizeVector()
  print("old magnitude: " .. math.sqrt(vector.x * vector.x + vector.y * vector.y))
  print("new magnitude: " .. newMag)
  print("vector.x : " .. vector.x .. " vector.y : " .. vector.y)
  print("unitVector x : " .. unitVector.x .. " unitVector.y : " .. unitVector.y)
end

function vectorModule.draw()
  love.graphics.print("vector", origin.x, origin.y)
  love.graphics.print("unitVector", origin.x + xOffset, origin.y)
  love.graphics.setLineWidth(4)
  love.graphics.line(origin.x, origin.y, origin.x + vector.x * scaleVec, origin.y + vector.y * scaleVec)
  love.graphics.line(origin.x + xOffset, origin.y, origin.x + xOffset + unitVector.x * scaleVec, origin.y + unitVector.y * scaleVec)
end

return vectorModule