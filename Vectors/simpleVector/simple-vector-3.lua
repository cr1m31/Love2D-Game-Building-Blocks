local simpleVectorAxisModule = require("simpleVector.simple-vector-axis")

local screenWidth = love.graphics.getWidth()
local screenHeight = love.graphics.getHeight()

local origin = {x = screenWidth * 0.5, y = screenHeight * 0.5}

local vector = {
  x =   100,
  y = - 100
}

local xAxisProjectionMatrix = {
  1,0,
  0,0
}

local yAxisProjectionMatrix = {
  0,0,
  0,1
}

local xInversionMatrix = {
  1, 0,
  0,-1
}

local yInversionMatrix = {
  -1, 0,
   0, 1
}

function multiplyVectorWithMatrix(matrixP, vectorP)
  vectorP.x = matrixP[1] * vectorP.x + matrixP[2] * vectorP.y
  vectorP.y = matrixP[3] * vectorP.x + matrixP[4] * vectorP.y
end

function love.keypressed(key, scancode, isrepeat)
  if key == "x" then
    multiplyVectorWithMatrix(xAxisProjectionMatrix, vector)
  end
  
  if key == "y" then
    multiplyVectorWithMatrix(yAxisProjectionMatrix, vector)
  end
  
  if key == "i" then
    multiplyVectorWithMatrix(xInversionMatrix, vector)
  end
  
  if key == "j" then
    multiplyVectorWithMatrix(yInversionMatrix, vector)
  end
  
end

function love.load()
  simpleVectorAxisModule.createAxis(screenWidth,screenHeight)
end

function love.draw()
  simpleVectorAxisModule.drawAxis()
  
  love.graphics.line(origin.x, origin.y, origin.x + vector.x, origin.y + vector.y)
  love.graphics.circle("line", origin.x + vector.x, origin.y + vector.y, 10)
end