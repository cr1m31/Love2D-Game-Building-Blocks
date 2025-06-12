local velocityDampingModule = {}

function velocityDampingModule.reduceVelocity(player, damping)
    player.velocity.x = player.velocity.x * damping
    player.velocity.y = player.velocity.y * damping
end

return velocityDampingModule