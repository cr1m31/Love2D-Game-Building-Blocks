-- vectorLogic.lua
local vectorLogic = {}

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

-- Draw debug helpers for a vector
function vectorLogic.drawDebug(baseX, baseY, vx, vy, maxLen)
  local multiplier = 20
  love.graphics.line(
    baseX, baseY,
    baseX + vx * multiplier,
    baseY + vy * multiplier
  )
  love.graphics.circle("line", baseX, baseY, maxLen * multiplier)
end

return vectorLogic
