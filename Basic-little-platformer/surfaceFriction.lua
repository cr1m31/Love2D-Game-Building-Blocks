local surfaceFrictionModule = {}

function surfaceFrictionModule.addFrictionWhenColliding(player)
    player.velocity.x = player.velocity.x * player.frictionPower 
    player.velocity.y = player.velocity.y * player.frictionPower
end

return surfaceFrictionModule