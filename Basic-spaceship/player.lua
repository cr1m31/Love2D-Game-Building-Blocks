local collisionModule = require("collision")

local frictionModule = require("friction")

local velocityModule = require("velocity")

local mapTilesBuilder = require("mapTilesBuilder")

local player = {
  x = 100,
  y = 350,
  width = 40,
  height = 40,
  speed = 20,
  velocity = {x = 0, y = 0},
  maxVelocity = 2.8,
  friction = {x = 0.99, y = 0.99},
  -- jumpforce can not be greater than max velocity
  jumpForce = 2.8,
  mass = 4,
  groundCollider = {x = 0, y = 0, width = 30, height = 4},
  image = love.graphics.newImage("/images/front-ship-low-res.png"),
  flameImage = love.graphics.newImage("/images/vertical-flame.png"),
  spawnPoint = {x = 0, y = 0}
}

local coll = nil
local visualVectorLineLengthMultiplier = 20

function player.updatePlayer(dt)
  movePlayer(dt)

  collisionModule.updateGroundCollider(player)

  -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  -- FIRST RESOLVE VELOCITY MAX LIMIT BEFORE TO IMLEMENT FRICTION
  ---------------------------------------------------------------------------------------------
  -- always add momentum friction 
  frictionModule.addHorizontalFriction(player, player.friction.x)
  -- if player is not grounded, add gravity and vertical friction
  if(not collisionModule.groundCollision(player.groundCollider)) then 
    frictionModule.addVerticalFriction(player, player.friction.y)
    addGravity(dt)
  end
  
end

function movePlayer(dt)
  local oldPlayerX = player.x
  local oldPlayerY = player.y

  -- move horizontally
  if(love.keyboard.isDown("a") )then
    -- increase velocity when pressing directional keys
    player.velocity.x = player.velocity.x - player.speed * dt
  elseif(love.keyboard.isDown("d") )then
    player.velocity.x = player.velocity.x + player.speed * dt
  end
  
  -- Adding velocity to player horizontal position
  
  player.x = player.x + velocityModule.limitMaxVelocityX(player.velocity, player.maxVelocity)
  -- check horitontal collision
  coll = collisionModule.collisionAABB(player)
  if coll then
    player.x = oldPlayerX -- revert x position only
    player.velocity.x = 0 -- when hitting a wall, reset velocity
  end

  -- move vertically
  if(love.keyboard.isDown("w") )then
    -- increase velocity when pressing directional keys
    player.velocity.y = player.velocity.y - player.speed * dt
  elseif(love.keyboard.isDown("s") )then
    player.velocity.y = player.velocity.y + player.speed * dt
  end

  -- Adding velocity to player vertical position

  player.y = player.y + velocityModule.limitMaxVelocityY(player.velocity, player.maxVelocity)
  -- check vertical collision
  coll = collisionModule.collisionAABB(player)
  if coll then
    player.y = oldPlayerY -- revert y position only
    player.velocity.y = 0 -- when hitting a wall, reset velocity
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

function playerJump()
  player.velocity.y = player.velocity.y - player.jumpForce
end

function addGravity(dt)
 player.velocity.y = player.velocity.y + player.mass * dt
end

function findSpawnLocation(map, tileValue)
  for rowNum, row in ipairs(map) do
    for colNum, tile in ipairs(row) do
      if tile == tileValue then
        return {
          x = (colNum - 1) * map.cellWidth,
          y = (rowNum - 1) * map.cellHeight,
        }
      end
    end
  end
  return nil
end

function player.spawnPlayer(firstMapPositionX, firstMapPositionY, direction)
  local map = mapTilesBuilder.getCurrentMap()

  if firstMapPositionX then
    player.x = firstMapPositionX
    player.y = firstMapPositionY
  else
    local tileToUse = 115  -- default spawn at 's'
    if direction == "fromPrevious" then
      tileToUse = 116  -- spawn at 't' if came from previous map
    end

    local spawnPos = findSpawnLocation(map, tileToUse)
    if spawnPos then
      player.x = spawnPos.x
      player.y = spawnPos.y
    else
      player.x = 0
      player.y = 0
    end
  end
end


function player.checkPlayerTeleportAndSpawn()
  local hitPreviousMapGate, gateInside = collisionModule.previousMapGatesCollisions(player)
  local hitNextMapGate, gateOutside = collisionModule.nextMapGatesCollisions(player)

  if hitPreviousMapGate then
    local previousMapNum = mapTilesBuilder.getCurrentMap().previousMapNum
    if previousMapNum then
      mapTilesBuilder.loadBuiltTiles(previousMapNum)
      player.spawnPlayer(nil, nil, "fromNext")  -- came from next map, so spawn at 115
    end
  elseif hitNextMapGate then
    local nextMapNum = mapTilesBuilder.getCurrentMap().nextMapNum
    if nextMapNum then
      mapTilesBuilder.loadBuiltTiles(nextMapNum)
      player.spawnPlayer(nil, nil, "fromPrevious") -- came from previous map, so spawn at 116
    end
  end
end



function player.drawPlayer()

  love.graphics.setColor(1, 0.5, 1)
  love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
  
  love.graphics.setColor(1, 1, 1)

  --love.graphics.draw(player.image, player.x + player.width / 2 - player.image:getWidth() / 2, player.y - player.height)
  local flameOffset = {x = - 23, y = 38}
  if(player.velocity.y < 0) then
    --love.graphics.draw(player.flameImage, player.x + flameOffset.x , player.y + flameOffset.y,0,0.24,0.24)
  end
  love.graphics.print("coll: " .. tostring(coll), 200, 250)

  love.graphics.print("velX: " .. player.velocity.x .. " velY: " .. player.velocity.y, 200, 200)

  love.graphics.line(player.x + (player.width / 2), player.y + (player.height / 2), player.x + (player.width / 2) + (player.velocity.x * visualVectorLineLengthMultiplier), player.y + (player.height / 2) + (player.velocity.y * visualVectorLineLengthMultiplier))

  -- draw player.groundCollider
  love.graphics.rectangle("line", player.groundCollider.x, player.groundCollider.y, player.groundCollider.width, player.groundCollider.height)
end

function love.keypressed(key , scancode , isrepeat )
 if(key == "space")  and collisionModule.groundCollision(player.groundCollider) then
  playerJump()
 end
end

return player