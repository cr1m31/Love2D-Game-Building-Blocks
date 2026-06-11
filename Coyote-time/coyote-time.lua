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
  width = 500,
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
    player.x = oldX
    player.velocity.x = 0
  end
  
  -- NEED TO CHANGE PLAYER POSITION BEFORE COLLISION CHECK !! (TO PREVENT GROUND STICKING)
  player.y = player.y + player.velocity.y * dt -- times dt converts pixels per second into pixels per frame
  
  if collisionCheckInside(player, platform) then
    player.y = oldY
    player.velocity.y = 0
  else
    addGravity(dt)
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

function playerJump(key)
  if key == "space" and checkIfPlayerIsGrounded() then
    player.velocity.y = - player.jumpForce
  end
end



-- !!!!    !!!!!!!!    !!!!!!!!    !!!!!!!!    !!!!
-- WRONG, NEED TO CHANGE IN MIN MAX OR CORRECT AS IN MY VIDEO ABOUT NORMALIZING PLAYER MOVEMENT (TOP DOWN GAME)
function limitMaxSpeed()
  local magnitude = math.sqrt(player.velocity.x * player.velocity.x + player.velocity.y * player.velocity.y)
  
  if magnitude >= player.maxSpeed.x then
    player.velocity.x = (player.velocity.x / magnitude) * player.maxSpeed.x
  end
  if magnitude >= player.maxSpeed.y then
    player.velocity.y = (player.velocity.y / magnitude) * player.maxSpeed.y
  end
  
end
-- !!!!    !!!!!!!!    !!!!!!!!    !!!!!!!!    !!!!



function coyoteTimeModule.update(dt)
  movePlayer(dt)
  
  bottomBoxCollider.x = player.x + 1
  bottomBoxCollider.y = player.y + 5
  
  limitMaxSpeed()
end

function coyoteTimeModule.draw()
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  love.graphics.setColor(0,1,0)
  love.graphics.rectangle("fill", platform.x, platform.y, platform.width, platform.height)
  
  love.graphics.rectangle("line", bottomBoxCollider.x, bottomBoxCollider.y, bottomBoxCollider.width, bottomBoxCollider.height)
  
  love.graphics.print("velx : " .. player.velocity.x .. " vely : " .. player.velocity.y, 100, 300)
  love.graphics.print("isGrounded : " .. tostring(checkIfPlayerIsGrounded()), 100, 330)
end

function love.keypressed(key, scancode, isrepeat)
  playerJump(key)
end


return coyoteTimeModule