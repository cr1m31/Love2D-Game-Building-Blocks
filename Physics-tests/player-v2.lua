local playerModule = {}

local gridModule = require("grid")

local player = {
  x = 80,
  y = 80,
  width = 20,
  height = 40,
  speed = 200,
  velocity = {x = 0, y = 0},
  acceleration = 150,
  gravity = {x = 0, y = 9.81},
}

function playerModule.update(dt)
  movePlayer(dt)
end

-- youtube tutorial about physics
-- https://youtu.be/jF1mnftlB-Q?si=KXcSXW6eGjW3lz4x
-- formula

function movePlayer(dt)
  local oldPlayerX = player.x
  local oldPlayerY = player.y
  
  -- left
  if love.keyboard.isDown("a") then
    player.x = player.x - player.speed * dt
  end
  -- right
  if love.keyboard.isDown("d") then
    player.x = player.x + player.speed * dt
  end
  
  if gridModule.checkCollisionsBetweenPlayerAndTiles(player) then
    player.x = oldPlayerX
  end
  
  -- up
  if love.keyboard.isDown("w") then
    player.y = player.y - player.speed * dt
  end
  -- down
  if love.keyboard.isDown("s") then
    player.y = player.y + player.speed * dt
  end
  
  if gridModule.checkCollisionsBetweenPlayerAndTiles(player) then
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