local collisionModule = {}

local mapManagerModule = require("mapManager")
local tileCollisionOffset = 0

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
      return true, tile
    end
  end
  return false, nil
end

function collisionModule.checkPlayerHorizonTalCollision(player)
  local coll, tile = collisionModule.checkPlayerCollisions(player)
  if (coll) then
    horizontalCollisionResponse(player, tile)
  end
end

function horizontalCollisionResponse(player, tile)
  if (player.velocity.x > 0) then
      player.x = tile.x - player.width - tileCollisionOffset
    else
      player.x = tile.x + tile.width + tileCollisionOffset
    end
    player.velocity.x = 0
end

function collisionModule.checkPlayerVerticalcollision(player)
  local coll, tile = collisionModule.checkPlayerCollisions(player)
  if (coll) then
    verticalCollisionResponse(player, tile)
  end
end

function verticalCollisionResponse(player, tile)
  if (player.velocity.y > 0) then
      player.y = tile.y - player.height - tileCollisionOffset
    else
      player.y = tile.y + tile.height + tileCollisionOffset
    end
    player.velocity.y = 0
end

function collisionModule.updateGroundCollider(player)
  player.groundCollider.x = player.x + 2
  player.groundCollider.y = player.y + player.height - 2
end

function collisionModule.checkGroundCollision(player)
  local coll, tile = collisionModule.checkPlayerCollisions(player.groundCollider)
  if (coll) then
    return true
  end
  return false
end

return collisionModule
