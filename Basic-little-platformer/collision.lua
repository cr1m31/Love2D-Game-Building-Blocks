local collisionModule = {}

local gridModule = require("grid")

local tiles = gridModule.getBuildedTilesInCollisions()

function collisionModule.collisionAABB(aa)
  for i, bb in ipairs(tiles) do
    if not (aa.x + aa.width < bb.x or 
      aa.x > bb.x + bb.width or
      aa.y + aa.height < bb.y or
      aa.y > bb.y + bb.height) then 
      return true
    end
  end
  return false
end

function collisionModule.drawColliders()
  for i, v in ipairs(tiles) do
    -- love.graphics.rectangle("line", v.x, v.y, v.width, v.height)
  end
end

return collisionModule