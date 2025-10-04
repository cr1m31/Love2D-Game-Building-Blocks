local vectorLogic = {}

local debugVectorLengthMultiplier = 20

local debugSquareForVectorLength = {
  x = 0,
  y = 0,
  width = 0,
  height = 0,
}

-- Normalize a 2D vector
function vectorLogic.normalize(x, y)
  local lenSq = x * x + y * y
  if lenSq == 0 then
    return 0, 0, 0
  end
  local len = math.sqrt(lenSq)
  return x / len, y / len, len
end

function vectorLogic.limit(x, y, maxLen)
  local lenSq = x * x + y * y
  if lenSq > maxLen * maxLen then
    local scale = maxLen / math.sqrt(lenSq)
    return x * scale, y * scale
  end
  return x, y
end

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

function vectorLogic.drawDebug(player)
  local multiplier = 20

  local centerX = player.x + player.width / 2
  local centerY = player.y + player.height / 2

  love.graphics.line(
    centerX, centerY,
    centerX + player.velocity.x * multiplier,
    centerY + player.velocity.y * multiplier
  )

  love.graphics.circle("line", centerX, centerY, player.velocityLimit * multiplier)

  local velLen = vectorLogic.length(player.velocity.x, player.velocity.y)
  love.graphics.print("velx: " .. player.velocity.x .. " vely: " .. player.velocity.y, 100, 200)
  love.graphics.print("vec len: " .. velLen, 100, 300)

  love.graphics.rectangle("line",
    debugSquareForVectorLength.x,
    debugSquareForVectorLength.y,
    debugSquareForVectorLength.width,
    debugSquareForVectorLength.height
  )
end

return vectorLogic
