local vectorModule = {}

function vectorModule.normalizeVector(player)
  local magnitude = math.sqrt(player.velocity.x * player.velocity.x + player.velocity.y * player.velocity.y)
  
  if magnitude == 0 then
    return
  end
  
  player.velocity.x = player.velocity.x / magnitude
  player.velocity.y = player.velocity.y / magnitude
  
  magnitude = magnitude / magnitude
  return magnitude
  
end

local scalingVector = 60
function vectorModule.draw(player)
  love.graphics.line(player.x + player.width / 2, player.y + player.height / 2, 
    (player.x + player.width / 2) + player.velocity.x * scalingVector,
    (player.y + player.height / 2) + player.velocity.y * scalingVector)
  
  love.graphics.print("real magnitude : " .. math.sqrt(player.velocity.x * player.velocity.x + player.velocity.y * player.velocity.y), 300, 200 )
  
  love.graphics.circle("line", player.x + player.width / 2, player.y + player.height / 2, player.velocityLimit)
  
end

return vectorModule