local vectorModule = {}

function vectorModule.normalizeVector(player)
  local magnitude = 0
  
  local squaredAPlusB = player.velocity.x * player.velocity.x + player.velocity.y * player.velocity.y
  local velocityLimitSquared = player.velocityLimit * player.velocityLimit
  
  -- preventing instant velocity and blocked steering wheel
  if squaredAPlusB > velocityLimitSquared then
    magnitude = math.sqrt(squaredAPlusB)
    
    if magnitude == 0 then
      return
    end
    
    local scalingFactor = player.velocityLimit / magnitude
    player.velocity.x = player.velocity.x * scalingFactor
    player.velocity.y = player.velocity.y * scalingFactor
  end
end

local scalingVector = 1
function vectorModule.draw(player)
  love.graphics.line(player.x + player.width / 2, player.y + player.height / 2, 
    (player.x + player.width / 2) + player.velocity.x * scalingVector,
    (player.y + player.height / 2) + player.velocity.y * scalingVector)
  
  love.graphics.circle("line", player.x + player.width / 2, player.y + player.height / 2, player.velocityLimit)
  
end

return vectorModule