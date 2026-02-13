local vectorModule = {}

function vectorModule.normalizeVector(player)
  -- take a triangle with three sides abc
  -- a = length of the side on the y axis |
  -- b = length of the side on the x axis ̣__
  -- c = length of the hypotenuse (= magnitude of the vector)
  -- formula:: a^ + b^ = c^ (^ = squared = **)
  -- c = square root of (a^ + b^)
  
  local magnitude = 0
  local oldX = player.velocity.x
  local oldY = player.velocity.y
  
  local limitSquared = player.velocityLimit * player.velocityLimit
  
  local squaredAPlusB = oldX * oldX + oldY * oldY
  if squaredAPlusB == 0 then
    return
  end
  
  if squaredAPlusB > limitSquared then
    magnitude = math.sqrt(squaredAPlusB)
    
    local scalingFactor = player.velocityLimit / magnitude
    player.velocity.x = oldX * scalingFactor
    player.velocity.y = oldY * scalingFactor
  end
end

function vectorModule.draw(player)
  love.graphics.line(player.x + player.width / 2, player.y + player.height / 2, 
    (player.x + player.width / 2) + player.velocity.x,
    (player.y + player.height / 2) + player.velocity.y)
  
  love.graphics.circle("line", player.x + player.width / 2, player.y + player.height / 2, player.velocityLimit)
end

return vectorModule