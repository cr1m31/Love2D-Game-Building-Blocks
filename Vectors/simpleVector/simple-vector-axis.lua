local simpleVectorAxisModule = {}
local xAxis = {}
local yAxis = {}
local xMargin = 200
local yMargin = 100

function simpleVectorAxisModule.createAxis(sw,sh)
  xAxis = {x = 0, y = sh * 0.5, x1 = sw, y1 = sh * 0.5}
  yAxis = {x = sw * 0.5, y = 0, x1 = sw * 0.5, y1 = sh }
end

function simpleVectorAxisModule.drawAxis()
  love.graphics.setColor(0,0,1)
  love.graphics.line(xAxis.x + xMargin, xAxis.y, xAxis.x1 - xMargin, xAxis.y1)
  love.graphics.setColor(1,0,0)
  love.graphics.line(yAxis.x, yAxis.y + yMargin, yAxis.x1, yAxis.y1 - yMargin)
  love.graphics.setColor(1,1,1)
  
end

return simpleVectorAxisModule