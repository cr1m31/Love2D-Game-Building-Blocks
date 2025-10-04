-- vectorLogic.lua
local vectorLogic = {}


local debugVectorLengthMultiplier = 20

local debugSquareForVectorLength = {
  x = 0,
  y = 0,
  width = 0,
  height = 0,
}

-- Normalize a 2D vector
-- Returns: normalized x, y, and length
function vectorLogic.normalize(x, y)
  local lenSq = x * x + y * y
  if lenSq == 0 then
    return 0, 0, 0
  end
  local len = math.sqrt(lenSq)
  return x / len, y / len, len
end

-- Limit vector length to a maximum
function vectorLogic.limit(x, y, maxLen)
  local lenSq = x * x + y * y
  if lenSq > maxLen * maxLen then
    local scale = maxLen / math.sqrt(lenSq)
    return x * scale, y * scale
  end
  return x, y
end

-- Return the vector's length
function vectorLogic.length(x, y)
  return math.sqrt(x * x + y * y)
end

function vectorLogic.updateSquareVectorSize(player)
  local cx = player.x + player.width / 2
  local cy = player.y + player.height / 2

  local halfW = player.velocityLimit * debugVectorLengthMultiplier
  local halfH = player.velocityLimit * debugVectorLengthMultiplier

  debugSquareForVectorLength.x = cx - halfW
  debugSquareForVectorLength.y = cy - halfH
  debugSquareForVectorLength.width = halfW * 2
  debugSquareForVectorLength.height = halfH * 2
end

-- Draw debug helpers for a player’s velocity vector
function vectorLogic.drawDebug(player)
  local multiplier = 20

  -- Calculate the center of the player
  local centerX = player.x + player.width / 2
  local centerY = player.y + player.height / 2

  -- Draw the velocity direction line
  love.graphics.line(
    centerX, centerY,
    centerX + player.velocity.x * multiplier,
    centerY + player.velocity.y * multiplier
  )

  -- Draw circular limit indicator
  love.graphics.circle("line", centerX, centerY, player.velocityLimit * multiplier)

  -- Draw debug text
  local velLen = vectorLogic.length(player.velocity.x, player.velocity.y)
  love.graphics.print("velx: " .. player.velocity.x .. " vely: " .. player.velocity.y, 100, 200)
  love.graphics.print("vec len: " .. velLen, 100, 300)

  -- Draw bounding square (assuming it’s globally defined)
  love.graphics.rectangle("line",
    debugSquareForVectorLength.x,
    debugSquareForVectorLength.y,
    debugSquareForVectorLength.width,
    debugSquareForVectorLength.height
  )
end

return vectorLogic
