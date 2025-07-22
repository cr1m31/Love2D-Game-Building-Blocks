local velocityModule = {}

function velocityModule.limitMaxVelocityX(vel, maxVel)
    if vel.x > maxVel.x then
        vel.x = math.min(vel.x, maxVel.x)
    elseif vel.x < -maxVel.x then
        vel.x = math.max(vel.x, -maxVel.x)
    end
    return vel.x
end

function velocityModule.limitMaxVelocityY(vel, maxVel)
    if vel.y > maxVel.y then
        vel.y = math.min(vel.y, maxVel.y)
    elseif vel.y < -maxVel.y then
        vel.y = math.max(vel.y, -maxVel.y)
    end
    return vel.y
end

return velocityModule
