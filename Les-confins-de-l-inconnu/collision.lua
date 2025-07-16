local collisionModule = {}

function collisionModule.collisionAABB(a,b)
    if (a.x + a.width <= b.x or
        a.x >= b.x + b.width or
        a.y + a.height <= b.y or
        a.y >= b.y + b.height) then
        return false
    else
        return true
    end
end

return collisionModule