local frictionModule = {}

function frictionModule.addHorizontalFriction(object, force)
    object.velocity.x = (object.velocity.x * force)  
end

function frictionModule.addVerticalFriction(object, force)
    object.velocity.y = (object.velocity.y * force)
end

return frictionModule