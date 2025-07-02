local collisionModule = {}
local mapTilesBuilderModule = require("mapTilesBuilder")

function collisionModule.collisionAABB(aa)
  local tiles = mapTilesBuilderModule.getBuiltTilesInCollisions()
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

function collisionModule.groundCollision(aa)
  local tiles = mapTilesBuilderModule.getBuiltTilesInCollisions()
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

function collisionModule.updateGroundCollider(player)
  player.groundCollider.x = player.x + player.width / 2 - (player.groundCollider.width / 2)
  player.groundCollider.y = player.y + player.height
end

function collisionModule.drawColliders()
  local tiles = mapTilesBuilderModule.getBuiltTilesInCollisions()
  for i, v in ipairs(tiles) do
    love.graphics.setColor(1,0,0)
    love.graphics.rectangle("line", v.x, v.y, v.width, v.height)
  end
end

return collisionModule
