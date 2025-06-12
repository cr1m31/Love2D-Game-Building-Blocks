local collisionModule = require("collision")
local velocityModule = require("velocity")
local velocityDampingModule = require("velocityDamping")
local surfaceFrictionModule = require("surfaceFriction")

local player = {
  x = 100,
  y = 350,
  width = 40,
  height = 40,
  center = {x = 0, y = 0},
  speed = 10,
  velocity = {x = 0, y = 0},
  maxVelocity = 4,
}

local coll = nil

function checkIfPlayerIsMoving()
  if love.keyboard.isDown("a") or 
    love.keyboard.isDown("d") or
    love.keyboard.isDown("w") or 
    love.keyboard.isDown("s") then
    return true
  else
    return false
  end
end

function player.updatePlayer(dt)
  movePlayer(dt)
  player.center = {
    x = player.x + (player.width / 2),
    y = player.y + (player.height / 2)
  }

  if checkIfPlayerIsMoving() == false then
    velocityDampingModule.reduceVelocity(player, 0.99)
  end
end


function movePlayer(dt)
  local oldPlayerX = player.x
  local oldPlayerY = player.y

  -- Apply acceleration based on input
  if love.keyboard.isDown("a") then
    player.velocity.x = player.velocity.x - player.speed * dt
  elseif love.keyboard.isDown("d") then
    player.velocity.x = player.velocity.x + player.speed * dt
  end

  if love.keyboard.isDown("w") then
    player.velocity.y = player.velocity.y - player.speed * dt
  elseif love.keyboard.isDown("s") then
    player.velocity.y = player.velocity.y + player.speed * dt
  end

  -- Limit the total velocity vector magnitude
  velocityModule.limit2DVelocityMagnitude(player.velocity, player.maxVelocity)

  -- Move horizontally
  player.x = player.x + player.velocity.x
  coll = collisionModule.collisionAABB(player)
  if coll then
    player.velocity.x = 0
    player.x = oldPlayerX

    surfaceFrictionModule.addFrictionWhenColliding(player, 0.5)
  end

  -- Move vertically
  player.y = player.y + player.velocity.y
  coll = collisionModule.collisionAABB(player)
  if coll then
    player.velocity.y = 0
    player.y = oldPlayerY

    surfaceFrictionModule.addFrictionWhenColliding(player, 0.5)
  end
end

function player.drawPlayer()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  love.graphics.print("coll: " .. tostring(coll), 20, 20)
  velocityModule.drawVelocityDebug(player)
end

return player
