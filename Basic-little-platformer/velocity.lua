local velocityModule = {}

function velocityModule.limitMaxVelocityX(vel, maxVel)
  if (vel.x > maxVel) then
    vel.x = math.max(maxVel)
  elseif (vel.x < - maxVel) then
    vel.x = math.max(- maxVel)
  end
  return vel.x
end

function velocityModule.limitMaxVelocityY(vel, maxVel)
  if (vel.y > maxVel) then
    vel.y = math.max(maxVel)
  elseif (vel.y < - maxVel) then
    vel.y = math.max(- maxVel)
  end
  return vel.y
end

return velocityModule