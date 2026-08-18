local playerModule = {}

local player = {
  x = 100,
  y = 100,
  width = 30,
  height = 50,
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


function playerModule.update(dt)
  movePlayer(dt)
end

function playerModule.draw()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
end

return playerModule