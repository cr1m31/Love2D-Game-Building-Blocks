local vectorLogic = {}

local screenWidth = love.graphics.getWidth()
local screenHeight = love.graphics.getHeight()

local origin = {
  x = 0,
  y = 0
}

local vector = {
  x = 100,
  y = 0
}

local vectorLimitBox = {
  x = 0,
  y = 0,
  width = 0,
  height = 0
}

vectorLimitBox.width = 100
vectorLimitBox.height = 100

function vectorLogic.limitVelocity(player)
  local vx, vy = player.velocity.x, player.velocity.y
  local mag = math.sqrt(vx * vx + vy * vy)

  -- Calculate magnitude limit based on your x/y velocity limits
  local maxMag = math.sqrt(player.velocityLimit.x^2 + player.velocityLimit.y^2)

  if mag > maxMag then
    player.velocity.x = (vx / mag) * maxMag
    player.velocity.y = (vy / mag) * maxMag
  end
end


function vectorLogic.getNormalizedVector(x, y)
  local magnitude = math.sqrt(x * x + y * y)

  if magnitude == 0 then -- prevent a division by zero error
    return 0, 0
  end

  return x / magnitude, y / magnitude
end

function vectorLogic.update(playerInst)
  origin.x = playerInst.x + playerInst.width * 0.5
  origin.y = playerInst.y + playerInst.height * 0.5

  vectorLimitBox.x = playerInst.x
  vectorLimitBox.y = playerInst.y

  vector.x = playerInst.velocity.x
  vector.y = playerInst.velocity.y
end

function vectorLogic.draw()
  love.graphics.line(origin.x, origin.y, origin.x + vector.x, origin.y + vector.y)
  
  love.graphics.circle("line", origin.x + vector.x, origin.y + vector.y, 10) 
  
  love.graphics.rectangle("line", origin.x - 50, origin.y - 50, 100, 100)
end

return vectorLogic