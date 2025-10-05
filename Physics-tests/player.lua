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
  velocityLimit = 3,
  friction = 7,
  gravity = {x = 0, y = 4},
}

function playerModule.update(dt)
  movePlayer(dt)
  limitVelocity()
  addLinearFriction(dt)
  vectorLogic.updatePlayerVelocityDebugArea(player)
end

---------------------------------------------------------
-- Player movement and control logic
---------------------------------------------------------

function movePlayer(dt)
  local oldPlayerX = player.x
  local oldPlayerY = player.y
  
  local inputX, inputY = getRawInput()
  inputX, inputY = vectorLogic.normalizeVector2D(inputX, inputY)

  player.velocity.x = player.velocity.x + inputX * player.acceleration * dt
  player.velocity.y = player.velocity.y + inputY * player.acceleration * dt
  
  -- Move horizontally before collision test
  player.x = player.x + player.velocity.x
  if gridModule.checkCollisionsBetweenPlayerAndTiles(player) then
    player.velocity.x = 0
    player.x = oldPlayerX
  end
  
  -- Move vertically before collision test
  player.y = player.y + player.velocity.y
  if gridModule.checkCollisionsBetweenPlayerAndTiles(player) then
    player.velocity.y = 0
    player.y = oldPlayerY
  end
end

---------------------------------------------------------
-- Friction and velocity limitation
---------------------------------------------------------

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

function limitVelocity()
  player.velocity.x, player.velocity.y =
    vectorLogic.limitVectorMagnitude(player.velocity.x, player.velocity.y, player.velocityLimit)
end

---------------------------------------------------------
-- Input handling
---------------------------------------------------------

function getRawInput()
  local dx, dy = 0, 0
  if love.keyboard.isDown("a") then dx = dx - 1 end
  if love.keyboard.isDown("d") then dx = dx + 1 end
  if love.keyboard.isDown("w") then dy = dy - 1 end
  if love.keyboard.isDown("s") then dy = dy + 1 end
  return dx, dy
end

---------------------------------------------------------
-- Drawing and debugging
---------------------------------------------------------

function playerModule.draw()
  if gridModule.checkCollisionsBetweenPlayerAndTiles(player) then
    love.graphics.setColor(1, 0, 0)
  else
    love.graphics.setColor(1, 1, 1)
  end

  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  vectorLogic.drawPlayerVelocityDebug(player)
end

return playerModule
