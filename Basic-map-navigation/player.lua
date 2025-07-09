local playerModule = {}

local player = {
  x = 50,
  y = 80,
  width = 40,
  height = 40,
  speed = 100,
}

function movePlayer(dt)
  if love.keyboard.isDown("a") then
    player.x = player.x - player.speed * dt
  end
  if love.keyboard.isDown("d") then
    player.x = player.x + player.speed * dt
  end
end

function playerModule.updatePlayer(dt)
  movePlayer(dt)
end

function playerModule.drawPlayer()
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end

return playerModule