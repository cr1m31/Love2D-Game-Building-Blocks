local collisionModule = {}

local mapManagerModule = require("mapManager")

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

function collisionModule.checkPlayerCollisions(player)
  for _, tile in ipairs(mapManagerModule.getBuiltTiles()) do
    if (collisionModule.collisionAABB(player, tile)) then 
      return true   
    end
  end
  return false
end

return collisionModule