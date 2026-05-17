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

local frictionPower = 0.8

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

  -- Move horizontally (vertical collision)
  player.x = player.x + player.velocity.x
  coll = collisionModule.collisionAABB(player)
  if coll then
    
    player.x = oldPlayerX

    player.velocity.x = 0

    surfaceFrictionModule.addFrictionWhenColliding(player, frictionPower)
  end

  -- Move vertically (horizontal collision)
  player.y = player.y + player.velocity.y
  coll = collisionModule.collisionAABB(player)
  if coll then
    player.y = oldPlayerY

    player.velocity.y = 0
    surfaceFrictionModule.addFrictionWhenColliding(player, frictionPower)
  end

  --[[
    Collision Reaction (Axis Separation)

    It's important to distinguish between:
      1. Collision Detection – Checking if an object is colliding with another.
      2. Collision Reaction – Responding appropriately when a collision is detected.

    The key idea is to process movement and collisions per axis, frame by frame.
    Each frame:
      - Move the player a small amount on one axis.
      - Immediately check for collisions.
      - If a collision is detected, resolve it on that same axis (e.g., revert movement and reset velocity).

    This is done separately for the X and Y axes:

      a. Move the player along the X-axis.
      b. Check for any collisions.
      c. If there's a collision, revert X movement and reset X velocity.
      d. Move the player along the Y-axis.
      e. Check for any collisions.
      f. If there's a collision, revert Y movement and reset Y velocity.

    This approach allows for simple and effective collision resolution
    without needing to know the direction or side of the collision explicitly.

    Note:
    There are multiple ways to handle 2D collisions. This axis-separated method works well
    for many games, but it has limitations. One common issue is **tunneling** — when fast-moving
    objects pass through thin walls without detecting a collision. To avoid tunneling,
    you may need to implement additional techniques such as continuous collision detection
    or limit object speed relative to wall thickness.
  ]]

end

function player.drawPlayer()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  love.graphics.print("coll: " .. tostring(coll), 20, 20)
  velocityModule.drawVelocityDebug(player)
end

return player
