local playerModule = {}

local gridModule = require("grid")

function lerp(a,b,t) return (1-t)*a + t*b end

local player = {
  x = 80,
  y = 80,
  width = 20,
  height = 40,
  velocity = {x = 0, y = 0},
  acceleration = 15,
}

function playerModule.update(dt)
  movePlayer(dt)
end

function movePlayer(dt)
  local oldPlayerX = player.x
  local oldPlayerY = player.y
  
  player.velocity.x = lerp(player.velocity.x, 0, 0.02)
  
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