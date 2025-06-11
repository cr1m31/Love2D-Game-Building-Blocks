local velocityModule = {}

-- Multiplier to scale the velocity vector when drawing for debug purposes
local debugVelocityVectorDrawScale = 4.5

--[[
  Limits the velocity of an object so that its total speed does not exceed maxSpeed.
  Preserves the direction but rescales the x and y components to maintain physics consistency.
]]
function velocityModule.limit2DVelocityMagnitude(velocityVector, maxSpeed)
  local currentSpeed = math.sqrt(velocityVector.x * velocityVector.x + velocityVector.y * velocityVector.y)

  if currentSpeed > maxSpeed then
    local rescaleFactor = maxSpeed / currentSpeed
    velocityVector.x = velocityVector.x * rescaleFactor
    velocityVector.y = velocityVector.y * rescaleFactor
  end
end

--[[
  Draws the player's current velocity vector as a line from their center,
  and prints the velocity components on screen for debugging.
]]
function velocityModule.drawVelocityDebug(player)
  love.graphics.print("Velocity X: " .. player.velocity.x .. " | Y: " .. player.velocity.y, 50, 50)

  love.graphics.line(
    player.center.x,
    player.center.y,
    player.center.x + player.velocity.x * debugVelocityVectorDrawScale,
    player.center.y + player.velocity.y * debugVelocityVectorDrawScale
  )
end

return velocityModule
