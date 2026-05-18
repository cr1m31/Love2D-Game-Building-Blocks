local frictionModule = {}

function frictionModule.addHorizontalFriction(object, force, dt)
    object.velocity.x = object.velocity.x * (1 - force * dt)
end

function frictionModule.addVerticalFriction(object, force, dt)
    object.velocity.y = object.velocity.y * (1 - force * dt)
end

return frictionModule