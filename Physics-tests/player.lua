-- player.lua
local playerModule = {}

local gridModule = require("grid")
local vectorLogic = require("vectorLogic")

local player = {
  x = 80,
  y = 80,
  width = 20,
  height = 40,
  acceleration = 18,
  velocity = {x = 0, y = 0},
  velocityLimit = 3, -- single scalar limit
  friction = 7,
  gravity = {x = 0, y = 4},
}

local debugVectorLengthMultiplier = 20

local debugSquareForVectorLength = {
  x = 0,
  y = 0,
  width = 0,
  height = 0,
}

function updateSquareVectorSize()
  local cx = player.x + player.width / 2
  local cy = player.y + player.height / 2

  local halfW = player.velocityLimit * debugVectorLengthMultiplier
  local halfH = player.velocityLimit * debugVectorLengthMultiplier

  debugSquareForVectorLength.x = cx - halfW
  debugSquareForVectorLength.y = cy - halfH
  debugSquareForVectorLength.width = halfW * 2
  debugSquareForVectorLength.height = halfH * 2
end

function playerModule.update(dt)
  movePlayer(dt)
  limitVelocity()
  addLinearFriction(dt)
  updateSquareVectorSize()
end

function movePlayer(dt)
  local oldPlayerX = player.x
  local oldPlayerY = player.y
  
  local dx, dy = getRawInput()
  dx, dy = vectorLogic.normalize(dx, dy)

  player.velocity.x = player.velocity.x + dx * player.acceleration * dt
  player.velocity.y = player.velocity.y + dy * player.acceleration * dt
  
  -- Move X before horizontal collision test
  player.x = player.x + player.velocity.x
  if gridModule.checkCollisionsBetweenPlayerAndTiles(player) then
    player.velocity.x = 0
    player.x = oldPlayerX
  end
  
  -- Move Y before vertical collision test
  player.y = player.y + player.velocity.y
  if gridModule.checkCollisionsBetweenPlayerAndTiles(player) then
    player.velocity.y = 0
    player.y = oldPlayerY
  end
end

function addLinearFriction(dt)
  if player.velocity.x > 0 then
    player.velocity.x = math.max(0, player.velocity.x - player.friction * dt)
  elseif player.velocity.x < 0 then
    player.velocity.x = math.min(0, player.velocity.x + player.friction * dt)
  end
  
  if player.velocity.y > 0 then
    player.velocity.y = math.max(0, player.velocity.y - player.friction * dt)
  elseif player.velocity.y < 0 then
    player.velocity.y = math.min(0, player.velocity.y + player.friction * dt)
  end
end

function getRawInput()
  local dx, dy = 0, 0
  if love.keyboard.isDown("a") then dx = dx - 1 end
  if love.keyboard.isDown("d") then dx = dx + 1 end
  if love.keyboard.isDown("w") then dy = dy - 1 end
  if love.keyboard.isDown("s") then dy = dy + 1 end
  return dx, dy
end

-- Circular clamp using vectorLogic
function limitVelocity()
  player.velocity.x, player.velocity.y =
    vectorLogic.limit(player.velocity.x, player.velocity.y, player.velocityLimit)
end

function playerModule.draw()
  if gridModule.checkCollisionsBetweenPlayerAndTiles(player) then
    love.graphics.setColor(1, 0, 0)
  else
    love.graphics.setColor(1, 1, 1)
  end

  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  
  local velLen = vectorLogic.length(player.velocity.x, player.velocity.y)
  love.graphics.print("velx: " .. player.velocity.x .. " vely: " .. player.velocity.y, 100, 200)
  love.graphics.print("vec len: " .. velLen, 100, 300)
  
  -- Debug visuals
  local cx = player.x + player.width / 2
  local cy = player.y + player.height / 2
  vectorLogic.drawDebug(cx, cy, player.velocity.x, player.velocity.y, player.velocityLimit)

  love.graphics.rectangle("line", 
    debugSquareForVectorLength.x, 
    debugSquareForVectorLength.y, 
    debugSquareForVectorLength.width, 
    debugSquareForVectorLength.height)
end

return playerModule
