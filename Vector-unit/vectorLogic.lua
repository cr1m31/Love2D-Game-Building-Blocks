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
    -- store old velocity
    local oldVelocityX = player.velocity.x
    local oldVelocityY = player.velocity.y

    -- get magnitude before square root of it
    local magnitudeSquared = oldVelocityX * oldVelocityX + oldVelocityY * oldVelocityY
    if magnitudeSquared == 0 then return end

    local limit = player.velocityLimit
    -- square limit to compare with squared magnitude
    local limitSquared = limit * limit
    
    -- avoid calling sqrt unnecessarily; only compute magnitude if speed exceeds the limit
    if magnitudeSquared > limitSquared then
        local magnitude = math.sqrt(magnitudeSquared)
        
        -- scaling factor to reduce the velocity to the speed limit
        local scalingFactor = limit / magnitude
        
        -- apply the scaling factor to each velocity component
        player.velocity.x = oldVelocityX * scalingFactor
        player.velocity.y = oldVelocityY * scalingFactor
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