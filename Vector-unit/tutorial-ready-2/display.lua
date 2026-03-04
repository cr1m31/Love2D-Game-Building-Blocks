local displayModule = {}

local scalingFactor = 30

function displayModule.draw(vector, origin, magnitude)
  drawCoordinatesSystem(origin)
  
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
  y1 = 0,
  x2 = love.graphics.getWidth() / 2,
  y2 = love.graphics.getHeight() - 0
}

function drawCoordinatesSystem(origin)
  love.graphics.setColor(0,0,1)
  love.graphics.line(horizontalLine.x1, horizontalLine.y1, horizontalLine.x2, horizontalLine.y2)
  love.graphics.setColor(1,1,1)
  love.graphics.setColor(1,0,0)
  love.graphics.line(verticalLine.x1, verticalLine.y1, verticalLine.x2, verticalLine.y2)
  love.graphics.setColor(1,1,1)
  local scaleSpacing = 30
  local scaleWidth = 5
  
  for i = 1, 10 do
    -- horizontal scale
    love.graphics.print(i, scaleSpacing * i + origin.x - 5, love.graphics.getHeight() / 2 + 10)
    love.graphics.line(scaleSpacing * i + origin.x, love.graphics.getHeight() / 2 - scaleWidth, scaleSpacing * i + origin.x, love.graphics.getHeight() / 2 + scaleWidth)
    
    love.graphics.print(- i, scaleSpacing * - i + origin.x - 5, love.graphics.getHeight() / 2 + 10)
    love.graphics.line(scaleSpacing * i - scaleSpacing + 100, love.graphics.getHeight() / 2 - scaleWidth, scaleSpacing * i - scaleSpacing + 100, love.graphics.getHeight() / 2 + scaleWidth)

  -- vertical scale
  love.graphics.print(- i, origin.x - 23, scaleSpacing * i + origin.y - 8)
  love.graphics.line(origin.x - scaleWidth, scaleSpacing * i + origin.y, origin.x + scaleWidth, scaleSpacing * i + origin.y)
  
  love.graphics.print(i, origin.x - 23, scaleSpacing * - i + origin.y - 8)
  love.graphics.line(origin.x - scaleWidth, scaleSpacing * - i + origin.y, origin.x + scaleWidth, scaleSpacing * - i + origin.y)

  end

end

return displayModule