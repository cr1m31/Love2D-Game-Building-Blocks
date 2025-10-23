local simpleVectorAxisModule = require("simpleVector.simple-vector-axis")


local screenWidth = love.graphics.getWidth()
local screenHeight = love.graphics.getHeight()

local centerX = screenWidth * 0.5
local centerY = screenHeight * 0.5

local origin = {0 + centerX, 0 + centerY}

local vector = {0, 0}

local speed = 200
local vectorTipRadius = 6

function placeVectorEndPoint(vecX, vecY)
  vector.x = vecX + centerX
  vector.y = vecY + centerY
end

function moveX(dt)
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
    {1,0},
    {0,0},
  }
function projectOnXaxis()
  vector.x = (xProjectionMatrix[1][1] * vector.x) + (xProjectionMatrix[1][2] * vector.y)
  vector.y = (xProjectionMatrix[2][1] * vector.x) + (xProjectionMatrix[2][2] * vector.y) + centerY
end

local xInversionMatrix = {
    {-1, 0},
    { 0, 1}
}
function invertXaxis()
    local vx, vy = vector.x, vector.y
    vector.x = (xInversionMatrix[1][1] * vx) + (xInversionMatrix[1][2] * vy) + centerX
    vector.y = (xInversionMatrix[2][1] * vx) + (xInversionMatrix[2][2] * vy) 
end

local yProjectionMatrix = {
    {0,0},
    {0,1},
  }
function projectOnYAxis()
  vector.x = (yProjectionMatrix[1][1] * vector.x) + (yProjectionMatrix[1][2] * vector.y) + centerX
  vector.y = (yProjectionMatrix[2][1] * vector.x) + (yProjectionMatrix[2][2] * vector.y)
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
  
  love.graphics.line(origin[1], origin[2], vector.x, vector.y)
  
  love.graphics.circle("line", vector.x, vector.y, vectorTipRadius)
  
  love.graphics.print("vecX : " .. 
    math.floor(vector.x - screenWidth * 0.5) .. 
    " \nvecY : " .. 
    math.floor(vector.y - screenHeight * 0.5), 
    screenWidth * 0.2, screenHeight * 0.2)
end