local playerModule = {}

local collisionModule = require("collision")
local doorsModule = require("doors")

local player = {
  x = 50,
  y = 80,
  width = 40,
  height = 40,
  speed = 300,
}

function playerModule.loadPlayer()

end

function movePlayer(dt)
  if love.keyboard.isDown("a") then
    player.x = player.x - player.speed * dt
  end
  if love.keyboard.isDown("d") then
    player.x = player.x + player.speed * dt
  end

  if love.keyboard.isDown("w") then
    player.y = player.y - player.speed * dt
  end

  if love.keyboard.isDown("s") then
    player.y = player.y + player.speed * dt
  end

end

function checkCollisionWithDoors()
  for doorNum, door in ipairs(doorsModule.getDoors()) do
    if(collisionModule.collisionAABB(player, door )) then
      print("door coll")
    end
  end
end

function playerModule.updatePlayer(dt)
  movePlayer(dt)
  checkCollisionWithDoors()
end

function playerModule.drawPlayer()
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end

return playerModule