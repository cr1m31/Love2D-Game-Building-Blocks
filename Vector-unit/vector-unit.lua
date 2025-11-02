local vectorUnitModule = {}

local screenWidth = love.graphics.getWidth()
local screenHeight = love.graphics.getHeight()

local playerModule = require("player")

local origin = {
  x = 0,
  y = 0
}

local vector = {
  x = 100,
  y = 0
}

local vectorLimitBox = {
  x = 0,
  y = 0,
  width = 0,
  height = 0
}

vectorLimitBox.width = 100
vectorLimitBox.height = 100

local x, y, w, h = playerModule.getPlayerPosAndDimensions()

function vectorUnitModule.update()
  
  origin.x, origin.y = x + w * 0.5, y + h * 0.5
  
  vectorLimitBox.x = x
  vectorLimitBox.y = y
  
end

function vectorUnitModule.draw()
  love.graphics.line(origin.x, origin.y, origin.x + vector.x, origin.y + vector.y)
  
  love.graphics.circle("line", origin.x + vector.x, origin.y + vector.y, 10) 
  
  love.graphics.rectangle("line", origin.x - 100, origin.y - 100, 200, 200)
end

return vectorUnitModule