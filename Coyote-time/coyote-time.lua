local coyoteTimeModule = {}

local player = {
  x = 200,
  y = 100,
  width = 50,
  height = 50,
  speed = 10,
  velocity = {x = 0, y = 0},
  acceleration = 3,
  gravity = 8.1,
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
    player.velocity.x = player.velocity.x - player.speed * player.acceleration * dt
  end
  if love.keyboard.isDown("d") then
    player.velocity.x = player.velocity.x + player.speed * player.acceleration * dt
  end
  
  if not collisionCheck(player, platform) then
    
    
    player.x = oldX
    player.velocity.x = 0
  end
  
  
  -- ALSO NEED TO FIND WHY WALL STICKING HAPPENS WHEN PLAYER TOUCHES SIDES ???
  
  
  player.x = player.x + player.velocity.x
  player.y = player.y + player.velocity.y
  
  -- NEED TO FIND WHY COLLISION IS WORKING (NO GROUND STICKING) WHEN MOVING THIS CODE AFTER PLAYER POSITION UPDATE ???
  if not collisionCheck(player, platform) then
    
    player.y = oldY
    player.velocity.y = 0
  
  else
  
    
  end
  
end

function collisionCheck(aa, bb)
  return aa.x + aa.width < bb.x or
    aa.x > bb.x + bb.width or
    aa.y + aa.height < bb.y or
    aa.y > bb.y + bb.height
end

function addGravity(dt)
  player.velocity.y = player.velocity.y + player.gravity * dt
end


function coyoteTimeModule.update(dt)
  movePlayer(dt)
  addGravity(dt)
end


function coyoteTimeModule.draw()
  love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
  love.graphics.rectangle("fill", platform.x, platform.y, platform.width, platform.height)
end


return coyoteTimeModule