local simpleVectorAxisModule = require("simpleVector.simple-vector-axis")

local screenWidth = love.graphics.getWidth()
local screenHeight = love.graphics.getHeight()

local centerX = screenWidth * 0.5
local centerY = screenHeight * 0.5

local origin = {x = 0, y = 0}

local vector = {0, 0}

local speed = 200
local vectorTipRadius = 6

function placeVectorEndPoint(vecX, vecY)
  vector.x = vecX
  vector.y = vecY
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
  vector.y = (xProjectionMatrix[2][1] * vector.x) + (xProjectionMatrix[2][2] * vector.y)
end

local xInversionMatrix = {
    {1, 0},
    {0,-1},
}
function invertXaxis()
    local vx, vy = vector.x, vector.y
    vector.x = (xInversionMatrix[1][1] * vx) + (xInversionMatrix[1][2] * vy) 
    vector.y = (xInversionMatrix[2][1] * vx) + (xInversionMatrix[2][2] * vy) 
end

local yProjectionMatrix = {
    {0,0},
    {0,1},
  }
function projectOnYAxis()
  vector.x = (yProjectionMatrix[1][1] * vector.x) + (yProjectionMatrix[1][2] * vector.y)
  vector.y = (yProjectionMatrix[2][1] * vector.x) + (yProjectionMatrix[2][2] * vector.y)
end

local yInversionMatrix = {
  {-1, 0},
  { 0, 1},
}

function invertYaxis()
  local vx, vy = vector.x, vector.y
    vector.x = (yInversionMatrix[1][1] * vx) + (yInversionMatrix[1][2] * vy) 
    vector.y = (yInversionMatrix[2][1] * vx) + (yInversionMatrix[2][2] * vy) 
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