local simpleVectorAxisModule = require("simpleVector.simple-vector-axis")

local screenWidth = love.graphics.getWidth()
local screenHeight = love.graphics.getHeight()

local centerX = screenWidth * 0.5
local centerY = screenHeight * 0.5

local origin = {x = 0, y = 0}

local vector = {x = 0, y = 0}

local speed = 200
local vectorTipRadius = 6

local function matrixMultiplyVector(m, v)
    -- multiply each horizontal row of the matrix by the column vector (vertical) to get new x and y
    local x = m[1] * v.x + m[2] * v.y
    local y = m[3] * v.x + m[4] * v.y
    -- store results first so v.x isn't overwritten before computing v.y
    v.x, v.y = x, y
end

local function placeVectorEndPoint(vecX, vecY)
  vector.x = vecX
  vector.y = vecY
end

local function moveX(dt)
  if love.keyboard.isDown("d") then
    vector.x = vector.x + speed * dt
  elseif love.keyboard.isDown("a") then
    vector.x = vector.x - speed * dt
  end
  
  if love.keyboard.isDown("s") then
    vector.y = vector.y + speed * dt
  elseif love.keyboard.isDown("w") then
    vector.y = vector.y - speed * dt
  end
end

local xProjectionMatrix = {
    1,0,
    0,0
}
local function projectOnXaxis()
  matrixMultiplyVector(xProjectionMatrix, vector)
end

local xInversionMatrix = {
    1, 0,
    0,-1
}
local function invertXaxis()
    matrixMultiplyVector(xInversionMatrix, vector)
end

local yProjectionMatrix = {
    0,0,
    0,1
}
local function projectOnYAxis()
  matrixMultiplyVector(yProjectionMatrix, vector)
end

local yInversionMatrix = {
  -1, 0,
   0, 1
}
local function invertYaxis()
  matrixMultiplyVector(yInversionMatrix, vector)
end

function love.keypressed(key, scancode, isrepeat)
  if key == "x" then
    projectOnXaxis()
  end
  if key == "y" then
    projectOnYAxis()
  end
  if key == "i" then 
    invertXaxis()
  end
  if key == "j" then
    invertYaxis()
  end
end

function love.load()
  placeVectorEndPoint(30, 30)
  simpleVectorAxisModule.createAxis(screenWidth,screenHeight)
end

function love.update(dt)
  moveX(dt)
end

function love.draw()
  simpleVectorAxisModule.drawAxis()

  love.graphics.line(origin.x + centerX, origin.y + centerY, vector.x + centerX, vector.y + centerY)
  love.graphics.circle("line", vector.x + centerX, vector.y + centerY, vectorTipRadius)
  
  love.graphics.print("vecX : " ..
    math.floor(vector.x - screenWidth * 0.5) + centerX ..
    " \nvecY : " ..
    math.floor(vector.y - screenHeight * 0.5) + centerY,
    screenWidth * 0.2, screenHeight * 0.2)
end
