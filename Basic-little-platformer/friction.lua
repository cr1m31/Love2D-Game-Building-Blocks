local frictionModule = {}

function frictionModule.addHorizontalFriction(object, force, dt)
    object.velocity.x = (object.velocity.x / force) * dt  
end

function frictionModule.addVerticalFriction(object, force, dt)
    object.velocity.y = (object.velocity.y / force) * dt  
end

return frictionModule