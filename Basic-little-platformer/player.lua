local collisionModule = require("collision")

local frictionModule = require("friction")

local player = {
  x = 100,
  y = 350,
  width = 40,
  height = 40,
  speed = 20,
  velocity = {x = 0, y = 0},
  jumpForce = 5,
  mass = 4,
  isGrounded = false,
}

local coll = nil
local visualVectorLineLengthMultiplier = 3

function player.updatePlayer(dt)
  movePlayer(dt)
  addGravity(dt)


  player.isGrounded = coll

  -- always add momentum friction except if grounded
  frictionModule.addHorizontalFriction(player, 0.02, dt)
  if(player.isGrounded) then 
    
    frictionModule.addVerticalFriction(player, 0.02, dt)
  else
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
  player.x = player.x + player.velocity.x
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
  player.y = player.y + player.velocity.y
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

function player.drawPlayer()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  
  love.graphics.print("coll: " .. tostring(coll), 200, 250)

  love.graphics.print("velX: " .. player.velocity.x .. " velY: " .. player.velocity.y, 200, 200)

  love.graphics.line(player.x + (player.width / 2), player.y + (player.height / 2), player.x + (player.width / 2) + (player.velocity.x * visualVectorLineLengthMultiplier), player.y + (player.height / 2) + (player.velocity.y * visualVectorLineLengthMultiplier))
end

function love.keypressed(key , scancode , isrepeat )
 if(key == "space") then
  playerJump()
 end
end

return player