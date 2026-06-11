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
  jumpForce = 3,
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
  if not collisionCheck(player, platform) then
    player.x = oldX
    player.velocity.x = 0
  end
  
  -- NEED TO CHANGE PLAYER POSITION BEFORE COLLISION CHECK !! (TO PREVENT GROUND STICKING)
  player.y = player.y + player.velocity.y * dt -- times dt converts pixels per second into pixels per frame
  
  if not collisionCheck(player, platform) then
    player.y = oldY
    player.velocity.y = 0    
  end
end

function collisionCheck(aa, bb)
  return aa.x + aa.width < bb.x or
    aa.x > bb.x + bb.width or
    aa.y + aa.height < bb.y or
    aa.y > bb.y + bb.height
end

function addGravity(dt)
  player.velocity.y = player.velocity.y + (gravitationalAcceleration * dt)
end

function coyoteTimeModule.update(dt)
  movePlayer(dt)
  addGravity(dt)
end

function coyoteTimeModule.draw()
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
  love.graphics.setColor(0,1,0)
  love.graphics.rectangle("fill", platform.x, platform.y, platform.width, platform.height)
end

return coyoteTimeModule