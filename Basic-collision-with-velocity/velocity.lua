local velocityModule = {}

local velocityVectorLengthMultiplier = 4.5

function calculateVelocityMagnitude(player)
  local velocityMagnitude = math.sqrt(player.velocity.x^2 + player.velocity.y^2)
  return velocityMagnitude
end


function velocityModule.limitPlayerVelocity(player)
  local velocityMagnitude = calculateVelocityMagnitude(player)
  
  if(velocityMagnitude > 0) then -- prevent dividing by 0
    -- normalize velocity vector down so its magnitude (length) is exactly 1.
    player.velocity.x = player.velocity.x / velocityMagnitude
    player.velocity.y = player.velocity.y / velocityMagnitude
  end
  
  -- Scale the normalized velocity by your desired max speed
  -- This makes the length of the vector equal to player.maxVelocity
  player.velocity.x = player.velocity.x * player.maxVelocity
  player.velocity.y = player.velocity.y * player.maxVelocity
end

function velocityModule.drawVelocityAndMagnitude(player)
  love.graphics.print("velX: " .. player.velocity.x .. " velY: " .. player.velocity.y, 50, 50)

  -- debug velocity with line
  love.graphics.line(player.center.x, player.center.y, player.center.x + player.velocity.x * velocityVectorLengthMultiplier, player.center.y +  player.velocity.y * velocityVectorLengthMultiplier)
end

-- Formula for normalizing velocity vector to 1

--LET'S SAY YOU HAVE A VELOCITY VECTOR V = <3, 4>. 
--CALCULATE THE MAGNITUDE: '|v|' = √(3² + 4²) = √25 = 5.
--DIVIDE EACH COMPONENT BY THE MAGNITUDE:
--V_: X = 3 / 5 = 0.6
--V_: Y = 4 / 5 = 0.8
--THE NORMALIZED VELOCITY VECTOR IS <0.6, 0.8>. 




return velocityModule