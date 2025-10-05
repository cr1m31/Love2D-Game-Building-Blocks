local vectorLogic = {}

-- Debug visualization settings
local debugVelocityVisualizationScale = 20

-- Defines the area used to visualize the player's velocity limit
local playerVelocityDebugArea = {
  x = 0,
  y = 0,
  width = 0,
  height = 0,
}

---------------------------------------------------------
-- Vector math utilities
---------------------------------------------------------

-- Normalize a 2D vector and return (x, y, magnitude)
function vectorLogic.normalizeVector2D(vectorX, vectorY)
  local magnitudeSquared = vectorX * vectorX + vectorY * vectorY
  if magnitudeSquared == 0 then
    return 0, 0, 0
  end
  local magnitude = math.sqrt(magnitudeSquared)
  return vectorX / magnitude, vectorY / magnitude, magnitude
end

-- Limit the magnitude of a 2D vector
function vectorLogic.limitVectorMagnitude(vectorX, vectorY, maxMagnitude)
  local magnitudeSquared = vectorX * vectorX + vectorY * vectorY
  if magnitudeSquared > maxMagnitude * maxMagnitude then
    local scale = maxMagnitude / math.sqrt(magnitudeSquared)
    return vectorX * scale, vectorY * scale
  end
  return vectorX, vectorY
end

-- Get the magnitude (length) of a 2D vector
function vectorLogic.getVectorMagnitude(vectorX, vectorY)
  return math.sqrt(vectorX * vectorX + vectorY * vectorY)
end

---------------------------------------------------------
-- Debug visualization logic for player velocity
---------------------------------------------------------

function vectorLogic.updatePlayerVelocityDebugArea(player)
  local playerCenterX = player.x + player.width / 2
  local playerCenterY = player.y + player.height / 2

  local halfWidth = player.velocityLimit * debugVelocityVisualizationScale
  local halfHeight = player.velocityLimit * debugVelocityVisualizationScale

  playerVelocityDebugArea.x = playerCenterX - halfWidth
  playerVelocityDebugArea.y = playerCenterY - halfHeight
  playerVelocityDebugArea.width = halfWidth * 2
  playerVelocityDebugArea.height = halfHeight * 2
end

function vectorLogic.drawPlayerVelocityDebug(player)
  local scale = debugVelocityVisualizationScale

  local playerCenterX = player.x + player.width / 2
  local playerCenterY = player.y + player.height / 2

  -- Draw the velocity vector
  love.graphics.line(
    playerCenterX, playerCenterY,
    playerCenterX + player.velocity.x * scale,
    playerCenterY + player.velocity.y * scale
  )

  -- Draw the velocity limit circle
  love.graphics.circle("line", playerCenterX, playerCenterY, player.velocityLimit * scale)

  -- Display velocity and magnitude info
  local velocityMagnitude = vectorLogic.getVectorMagnitude(player.velocity.x, player.velocity.y)
  love.graphics.print("Velocity X: " .. player.velocity.x .. " | Velocity Y: " .. player.velocity.y, 100, 200)
  love.graphics.print("Velocity Magnitude: " .. velocityMagnitude, 100, 300)

  -- Draw debug boundary square
  love.graphics.rectangle(
    "line",
    playerVelocityDebugArea.x,
    playerVelocityDebugArea.y,
    playerVelocityDebugArea.width,
    playerVelocityDebugArea.height
  )
end

return vectorLogic
