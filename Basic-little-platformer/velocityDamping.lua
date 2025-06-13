local velocityDampingModule = {}

function velocityDampingModule.reduceVelocity(player)
    player.velocity.x = player.velocity.x * player.velocityDamping
    player.velocity.y = player.velocity.y * player.velocityDamping
end

return velocityDampingModule