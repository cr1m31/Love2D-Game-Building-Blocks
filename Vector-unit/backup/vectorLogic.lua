local vectorLogic = {}

-- Normalize the player's velocity vector and limit its maximum magnitude
function vectorLogic.normalizeVectorAndLimitVelocity(player)
    local oldVelocityX = player.velocity.x
    local oldVelocityY = player.velocity.y

    local magnitudeSquared = oldVelocityX * oldVelocityX + oldVelocityY * oldVelocityY
    if magnitudeSquared == 0 then 
      return 
    end

    local limitSquared = player.velocityLimit * player.velocityLimit

    -- avoid calling sqrt unless speed exceeds limit
    if magnitudeSquared > limitSquared then
        local magnitude = math.sqrt(magnitudeSquared)
        
        local scalingFactor = player.velocityLimit / magnitude
        player.velocity.x = oldVelocityX * scalingFactor
        player.velocity.y = oldVelocityY * scalingFactor
    end
end

return vectorLogic
