local coyoteTimeModule = {}
local pixelPerMeter = 60
local gravitationalAcceleration =  9.8 * pixelPerMeter

local player = {
  x = 200,
  y = 100,
  width = 50,
  height = 50,
  velocity = {x = 0, y = 0},
  horizontalAcceleration = 600,
  jumpForce = 400, -- needs to be less than maxSpeed.y
  maxSpeed = {x = 200, y = 500},
}

local bottomBoxCollider = 
{
  x = 0,
  y = 0,
  width = 48,
  height = 48
}

local platform = {
  x = 150,
  y = 260,
  width = 700,
  height = 30,
}

function movePlayer(dt)
  local oldX = player.x
  local oldY = player.y
  
  if love.keyboard.isDown("a") then
    player.velocity.x = player.velocity.x - player.horizontalAcceleration * dt
  end
  if love.keyboard.isDown("d") then
    player.velocity.x = player.velocity.x + player.horizontalAcceleration * dt
  end
  
  -- NEED TO CHANGE PLAYER POSITION BEFORE COLLISION CHECK !! (TO PREVENT WALL STICKING)
  player.x = player.x + player.velocity.x * dt -- times dt converts pixels per second into pixels per frame
  if collisionCheckInside(player, platform) then
    
    player.velocity.x = 0
    player.x = oldX
  end
  
  addGravity(dt)  -- !!! ADD GRAVITY BEFORE MOVING THE PLAYER VERTICALLY !!!
  ---------------------- Or the player will keep be pushed down in the floor then 
  ---------------------- pulled back to  old y position so no stable velocity.y
  
  -- NEED TO CHANGE PLAYER POSITION BEFORE COLLISION CHECK !! (TO PREVENT GROUND STICKING)
  player.y = player.y + player.velocity.y * dt -- times dt converts pixels per second into pixels per frame
  
  if collisionCheckInside(player, platform) then
    player.velocity.y = 0
    player.y = oldY
  end
end

function collisionCheckInside(aa, bb)
  return aa.x + aa.width > bb.x and
    aa.x < bb.x + bb.width and
    aa.y + aa.height > bb.y and
    aa.y < bb.y + bb.height
end

function addGravity(dt)
  player.velocity.y = player.velocity.y + (gravitationalAcceleration * dt)
end

function checkIfPlayerIsGrounded()
  if collisionCheckInside(bottomBoxCollider, platform) then
    return true
  end
  return false
end

-- debug jump height
local startPlayerY = 0
local highestJumpY = 0

function playerJump(key)
  if key == "space" and checkIfPlayerIsGrounded() then
    player.velocity.y = - player.jumpForce -- adding instant jump not progressive force...
  end
  
  startPlayerY = player.y
  highestJumpY = 0
end

function limitMaxSpeed() -- limit max speed in four directions for platformer controls with different gravity max speed limit than horizontal max movement speed ...
  -- right
  if player.velocity.x > player.maxSpeed.x then
    player.velocity.x = player.maxSpeed.x
  end
  -- left
  if player.velocity.x < - player.maxSpeed.x then
    player.velocity.x = - player.maxSpeed.x
  end
  
  -- down
  if player.velocity.y > player.maxSpeed.y then
    player.velocity.y = player.maxSpeed.y
  end
  -- up
  if player.velocity.y < - player.maxSpeed.y then
    player.velocity.y = - player.maxSpeed.y
  end
end

function coyoteTimeModule.update(dt)
  movePlayer(dt)
  
  bottomBoxCollider.x = player.x + 1
  bottomBoxCollider.y = player.y + 5
  
  limitMaxSpeed()
  
  
  if not checkIfPlayerIsGrounded() then
    local currentHeight = startPlayerY - player.y
    if currentHeight > highestJumpY then
      highestJumpY = currentHeight
    end
  end
end

function coyoteTimeModule.draw()
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  love.graphics.setColor(0,1,0)
  love.graphics.rectangle("fill", platform.x, platform.y, platform.width, platform.height)
  
  love.graphics.rectangle("line", bottomBoxCollider.x, bottomBoxCollider.y, bottomBoxCollider.width, bottomBoxCollider.height)
  
  love.graphics.print("velx : " .. player.velocity.x .. " vely : " .. player.velocity.y, 100, 300)
  -- degug ground distance
  love.graphics.print("dist : " .. player.y - platform.y + player.height, 100, 330)
  
  -- peak
  love.graphics.print("peak : " .. highestJumpY, 100, 390)
  
  love.graphics.print("isGrounded : " .. tostring(checkIfPlayerIsGrounded()), 100, 360)
  
  -- draw movement vector magnified
  love.graphics.line(player.x + player.width / 2, player.y + player.height / 2, player.x + player.width / 2 + player.velocity.x, player.y + player.height / 2 + player.velocity.y)
end

function love.keypressed(key, scancode, isrepeat)
  playerJump(key)
end


return coyoteTimeModule