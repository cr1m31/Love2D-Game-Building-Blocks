local playerModule = {}

local collisionModule = require("collision")
local gridModule = require("grid")

local player = {
  x = 60,
  y = 80,
  width = 40,
  height = 60,
  speed = 60,
}

function movePlayer(dt)
  local oldPlayerX = player.x
  local oldPlayerY = player.y
  
  if love.keyboard.isDown("a") then
    player.x = player.x - player.speed * dt
  end
  if love.keyboard.isDown("d") then
    player.x = player.x + player.speed * dt
  end
  
  if checkIfPlayerIsInCollision() then
    player.x = oldPlayerX
  end
  
  if love.keyboard.isDown("w") then
    player.y = player.y - player.speed * dt
  end
  if love.keyboard.isDown("s") then
    player.y = player.y + player.speed * dt
  end
  
  if checkIfPlayerIsInCollision() then
    player.y = oldPlayerY
  end
  
end


function checkIfPlayerIsInCollision()
  for i, tile in ipairs(gridModule.getBuiltTiles()) do
    if collisionModule.collisionAABB(player, tile) then
      return true
    end
  end
  return false
end

function playerModule.update(dt)
  
  movePlayer(dt)
  
  
end

function playerModule.draw()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
  
  love.graphics.print(tostring(checkIfPlayerIsInCollision()), 100, 200)
end

return playerModule