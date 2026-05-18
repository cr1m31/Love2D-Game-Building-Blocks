local playerModule = {}

local collisionModule = require("collision")

local gateManagerModule = require("gateManager")

local player = {
  x = 50,
  y = 80,
  width = 40,
  height = 40,
  speed = 600,
}

function movePlayer(dt)
  
  local oldPlayerX = player.x
  local oldPlayerY = player.y

  -- move horizontally
  if love.keyboard.isDown("a") then
    player.x = player.x - player.speed * dt
  end
  if love.keyboard.isDown("d") then
    player.x = player.x + player.speed * dt
  end
  -- check horizontal collision after moving horizontally
  if (collisionModule.checkPlayerCollisions(player)) then
    player.x = oldPlayerX
  end

  -- move vertically
  if love.keyboard.isDown("w") then
    player.y = player.y - player.speed * dt
  end
  if love.keyboard.isDown("s") then
    player.y = player.y + player.speed * dt
  end
  -- check vertical collision after moving vertically
  if (collisionModule.checkPlayerCollisions(player)) then
    player.y = oldPlayerY
  end

end

function playerModule.updatePlayer(dt)
  movePlayer(dt)

  gateManagerModule.checkGateCollision(player)
end


function playerModule.drawPlayer()
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end

return playerModule
