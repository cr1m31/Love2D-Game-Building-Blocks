local displayModule = {}

local scalingFactor = 30

function displayModule.draw(vector, origin, magnitude)
  drawCoordinatesSystem()
  
  love.graphics.circle("line", vector.x * scalingFactor + origin.x, vector.y * scalingFactor + origin.y, 8)
  love.graphics.circle("line", origin.x, origin.y, 4)
  love.graphics.line(origin.x, origin.y, vector.x * scalingFactor + origin.x, vector.y * scalingFactor + origin.y)
  love.graphics.print("x : " .. vector.x .. "\n y : " .. vector.y .. "\n magnitude : " .. magnitude, 100, 100)
end

local horizontalLine = {
  x1 = 100, 
  y1 = love.graphics.getHeight() / 2, 
  x2 = love.graphics.getWidth() - 100, 
  y2 = love.graphics.getHeight() / 2
}

local verticalLine = {
  x1 = love.graphics.getWidth() / 2,
  y1 = 100,
  x2 = love.graphics.getWidth() / 2,
  y2 = love.graphics.getHeight() - 100
}

function drawCoordinatesSystem()
  love.graphics.setColor(0,0,1)
  love.graphics.line(horizontalLine.x1, horizontalLine.y1, horizontalLine.x2, horizontalLine.y2)
  love.graphics.setColor(1,1,1)
  love.graphics.setColor(1,0,0)
  love.graphics.line(verticalLine.x1, verticalLine.y1, verticalLine.x2, verticalLine.y2)
  love.graphics.setColor(1,1,1)
  
  for i = 1, 20 do
    love.graphics.line(10 * i, love.graphics.getHeight() / 2 - 10, 10 * i, love.graphics.getHeight() / 2 + 10)
  end
end

return displayModule