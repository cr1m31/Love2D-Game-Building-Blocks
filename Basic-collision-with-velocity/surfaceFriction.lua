local surfaceFrictionModule = {}

function surfaceFrictionModule.addFrictionWhenColliding(player, frictionForce)
    player.velocity.x = player.velocity.x * frictionForce 
    player.velocity.y = player.velocity.y * frictionForce
end

return surfaceFrictionModule