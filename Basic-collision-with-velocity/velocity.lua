local velocityModule = {}

local velocityVectorLengthMultiplier = 4.5

function velocityModule.limitVectorMagnitude(vec, max)
  local length = math.sqrt(vec.x * vec.x + vec.y * vec.y)
  if length > max then
    local scale = max / length
    vec.x = vec.x * scale
    vec.y = vec.y * scale
  end
end

function velocityModule.drawVelocityAndMagnitude(player)
  love.graphics.print("velX: " .. player.velocity.x .. " velY: " .. player.velocity.y, 50, 50)

  -- debug velocity with line
  love.graphics.line(player.center.x, player.center.y, player.center.x + player.velocity.x * velocityVectorLengthMultiplier, player.center.y +  player.velocity.y * velocityVectorLengthMultiplier)
end

return velocityModule