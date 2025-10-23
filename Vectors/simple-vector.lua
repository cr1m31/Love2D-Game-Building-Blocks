
local screenWidth = love.graphics.getWidth()
local screenHeight = love.graphics.getHeight()

local origin = {x = 0, y = 0}

local vector = {x = 0, y = 0}

local speed = 200

function love.load()
  placeVectorEndPoint(1 * 120, 1 * 80)
end

function placeVectorEndPoint(vecX, vecY)
  vector.x = vecX
  vector.y = vecY
end

function moveX(dt)
  if love.keyboard.isDown("right") then
    vector.x = vector.x + speed * dt
  elseif love.keyboard.isDown("left") then
    vector.x = vector.x - speed * dt
  end
  
  if love.keyboard.isDown("down") then
    vector.y = vector.y + speed * dt
  elseif love.keyboard.isDown("up") then
    vector.y = vector.y - speed * dt
  end
end

function love.update(dt)
  moveX(dt)
end

function love.draw()
  local centerX = screenWidth * 0.5
  local centerY = screenHeight * 0.5
  love.graphics.line(origin.x + centerX, origin.y + centerY, vector.x + centerX, vector.y + centerY)
end