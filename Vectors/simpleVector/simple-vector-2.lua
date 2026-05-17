local simpleVectorAxisModule = require("simpleVector.simple-vector-axis")

local screenWidth = love.graphics.getWidth()
local screenHeight = love.graphics.getHeight()

local vector2 = {x = 100, y = 100}
local origin2 = {x = screenWidth * 0.5, y = screenHeight * 0.5}

function setVectorLocation(x,y)
  vector2.x = x
  vector2.y = y
end

function multiplyMatrixWithVector(matrixP, vectorP)
  vectorP.x = matrixP[1] * vectorP.x + matrixP[2] * vectorP.y
  vectorP.y = matrixP[3] * vectorP.x + matrixP[4] * vectorP.y
end

local xProjectionMatrix = {
  1,0,
  0,0
}

local yProjectionMatrix = {
  0,0,
  0,1
}

local xInvertionMatrix = {
  1, 0,
  0,-1
}

local yInvertionMatrix = {
  -1,0,
   0,1
}

function love.keypressed(key, scancode, isrepeat)
  if key == "x" then
    multiplyMatrixWithVector(xProjectionMatrix, vector2)
  end
  
  if key == "y" then
    multiplyMatrixWithVector(yProjectionMatrix, vector2)
  end
  
  if key == "r" then
    setVectorLocation(100,100)
  end
  
  if key == "i" then
    multiplyMatrixWithVector(xInvertionMatrix, vector2)
  end
  
  if key == "j" then
    multiplyMatrixWithVector(yInvertionMatrix, vector2)
  end
  
end

function love.load()
  simpleVectorAxisModule.createAxis(screenWidth,screenHeight)
end

function love.draw()
  love.graphics.line(origin2.x, origin2.y, origin2.x + vector2.x, origin2.y + vector2.y)
  love.graphics.circle("line", origin2.x + vector2.x, origin2.y + vector2.y, 10)
  
  simpleVectorAxisModule.drawAxis()
end