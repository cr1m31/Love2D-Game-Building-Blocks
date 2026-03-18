local vectorModule = {}

local magnitude = 0

function vectorModule.normalizeVector(player)
  local oldX = player.velocity.x
  local oldY = player.velocity.y
  
  magnitude = math.sqrt(player.velocity.x * player.velocity.x + player.velocity.y * player.velocity.y)
  if magnitude == 0 then
    return
  end
  player.velocity.x = player.velocity.x / magnitude
  player.velocity.y = player.velocity.y / magnitude
end

function vectorModule.draw(player)
  love.graphics.line(player.x + player.width / 2, player.y + player.height / 2, 
    (player.x + player.width / 2) + player.velocity.x,
    (player.y + player.height / 2) + player.velocity.y)
  
  love.graphics.circle("line", player.x + player.width / 2, player.y + player.height / 2, player.velocityLimit)
  
  love.graphics.print("mag: " .. math.floor(magnitude), 150, 150)
end

return vectorModule