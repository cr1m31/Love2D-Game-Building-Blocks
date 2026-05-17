local vectorModule = {}

function vectorModule.normalizeVector(x, y)
  local magnitude = math.sqrt(x * x + y * y)
  
  if magnitude == 0 then
    return
  end
  
  x = x / magnitude
  y = y / magnitude
end

function vectorModule.limitVelocity(player)
  local magnitudeSquared = player.velocity.x * player.velocity.x + player.velocity.y * player.velocity.y 
  
  if magnitudeSquared == 0 then
    return
  end

  local scale = player.maxVelocity / math.sqrt(magnitudeSquared)
  
  player.velocity.x = player.velocity.x * scale
  player.velocity.y = player.velocity.y * scale
end


return vectorModule