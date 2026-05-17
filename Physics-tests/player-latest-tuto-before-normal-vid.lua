local playerModule = {}

local gridModule = require("grid")

local player = {
  x = 80,
  y = 80,
  width = 20,
  height = 40,
  velocity = {x = 0, y = 0},
  velocityLimit = {x = 3, y = 3},
  acceleration = 15,
  friction = 7,
}

function playerModule.update(dt)
  movePlayer(dt)
  
  addLinearFriction(dt)
  
  limitVelocity()
end

function movePlayer(dt)
  local oldPlayerX = player.x
  local oldPlayerY = player.y
  
  -- left
  if love.keyboard.isDown("a") then
    player.velocity.x = player.velocity.x - player.acceleration * dt
  end
  -- right
  if love.keyboard.isDown("d") then
    player.velocity.x = player.velocity.x + player.acceleration * dt
  end
  
  player.x = player.x + player.velocity.x
  
  if gridModule.checkCollisionsBetweenPlayerAndTiles(player) then
    player.velocity.x = 0
    
    player.x = oldPlayerX
  end
  
  -- up
  if love.keyboard.isDown("w") then
    player.velocity.y = player.velocity.y - player.acceleration * dt
  end
  -- down
  if love.keyboard.isDown("s") then
    player.velocity.y = player.velocity.y + player.acceleration * dt
  end
  
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

function limitVelocity()
  if player.velocity.x > player.velocityLimit.x then
    player.velocity.x = player.velocityLimit.x
  elseif player.velocity.x < - player.velocityLimit.x then
    player.velocity.x = - player.velocityLimit.x
  end
  
  if player.velocity.y > player.velocityLimit.y then
    player.velocity.y = player.velocityLimit.y
  elseif player.velocity.y < - player.velocityLimit.y then
    player.velocity.y = - player.velocityLimit.y
  end
end

function playerModule.draw()
  if gridModule.checkCollisionsBetweenPlayerAndTiles(player) then
    love.graphics.setColor(1,0,0)
  else
    love.graphics.setColor(1,1,1)
  end

  
  love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
  
  love.graphics.print("velx: " .. player.velocity.x .. " vely: " .. player.velocity.y, 100, 200)
end

return playerModule