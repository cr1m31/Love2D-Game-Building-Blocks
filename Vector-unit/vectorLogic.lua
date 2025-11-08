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

-- Normalize the player's velocity vector and limit its maximum magnitude
function vectorLogic.normalizeVectorAndLimitVelocity(player)
    local vx, vy = player.velocity.x, player.velocity.y

    local magnitude = math.sqrt(vx * vx + vy * vy)

    if magnitude == 0 then
        return
    end

    if magnitude > player.velocityLimit then
        local normalizationFactor = player.velocityLimit / magnitude
        player.velocity.x = vx * normalizationFactor
        player.velocity.y = vy * normalizationFactor
    end
end


function vectorLogic.update(player)
  origin.x = player.x + player.width * 0.5
  origin.y = player.y + player.height * 0.5

  vectorLimitBox.x = player.x
  vectorLimitBox.y = player.y

  vector.x = player.velocity.x
  vector.y = player.velocity.y
end

function vectorLogic.draw()
  love.graphics.line(origin.x, origin.y, origin.x + vector.x, origin.y + vector.y)
  
  love.graphics.circle("line", origin.x + vector.x, origin.y + vector.y, 10) 
  
  love.graphics.rectangle("line", origin.x - 80, origin.y - 80, 160, 160)
end

return vectorLogic