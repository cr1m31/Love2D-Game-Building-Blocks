local gravityModule = {}

function gravityModule.addGravity(player, dt)
    player.velocity.y = player.velocity.y + player.gravityForce * dt
end

return gravityModule