local playerModule = {}

local player = {
  x = 100,
  y = 200,
  width = 40,
  height = 60,
  velocity = {x = 0, y = 0},
  acceleration = 2
}

function movePlayer()
  if love.keyboard.isDown("a") then
    player.velocity.x = - 1
  end
  if love.keyboard.isDown("d") then
    player.velocity.x = 1
  end
  
  if love.keyboard.isDown("w") then
    player.velocity.y = - 1
  end
  if love.keyboard.isDown("s") then
    player.velocity.y = 1
  end
  
  if love.keyboard.isDown("a") or love.keyboard.isDown("d") or love.keyboard.isDown("w") or love.keyboard.isDown("s") then
    
  else
    player.velocity.x = 0
    player.velocity.y = 0
  end
  
  player.x = player.x + player.velocity.x
  player.y = player.y + player.velocity.y
  
end

function playerModule.getPlayerAttributes()
  return player
end

function playerModule.update()
  movePlayer()
end

function playerModule.draw()
  love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
end

return playerModule