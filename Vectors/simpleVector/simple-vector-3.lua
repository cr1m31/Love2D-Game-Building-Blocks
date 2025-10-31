local simpleVectorAxisModule = require("simpleVector.simple-vector-axis")

local screenWidth = love.graphics.getWidth()
local screenHeight = love.graphics.getHeight()



function love.load()
  simpleVectorAxisModule.createAxis(screenWidth,screenHeight)
end

function love.draw()
  simpleVectorAxisModule.drawAxis()
end