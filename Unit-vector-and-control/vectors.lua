local vectorModule = {}

function vectorModule.normalizeVector(player)
  local oldX = player.velocity.x
  local oldY = player.velocity.y
  
  
end

function vectorModule.draw(player)
  love.graphics.line(player.x + player.width / 2, player.y + player.height / 2, 
    (player.x + player.width / 2) + player.velocity.x,
    (player.y + player.height / 2) + player.velocity.y)
  
  love.graphics.circle("line", player.x + player.width / 2, player.y + player.height / 2, player.velocityLimit)
end

return vectorModule