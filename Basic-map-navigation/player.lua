local playerModule = {}

local collisionModule = require("collision")

local mapManagerModule = require("mapManager")

local player = {
  x = 50,
  y = 80,
  width = 40,
  height = 40,
  speed = 300,
}

function playerModule.loadPlayer()

end

function movePlayer(dt)
  
  local oldPlayerX = player.x
  local oldPlayerY = player.y

  -- move horizontally
  if love.keyboard.isDown("a") then
    player.x = player.x - player.speed * dt
  end
  if love.keyboard.isDown("d") then
    player.x = player.x + player.speed * dt
  end
  -- check horizontal collision after moving horizontally
  if (checkPlayerCollisions()) then
    player.x = oldPlayerX
  end

  -- move vertically
  if love.keyboard.isDown("w") then
    player.y = player.y - player.speed * dt
  end
  if love.keyboard.isDown("s") then
    player.y = player.y + player.speed * dt
  end
  -- check vertical collision after moving vertically
  if (checkPlayerCollisions()) then
    player.y = oldPlayerY
  end

end

function playerModule.updatePlayer(dt)
  movePlayer(dt)
  checkPlayerCollisionWithEntyGates()
  checkPlayerCollisionWithExitGates()
  
end

function checkPlayerCollisions()
  for tileNum, tile in ipairs(mapManagerModule.getBuiltTiles()) do
    if (collisionModule.collisionAABB(player, tile)) then 
      return true   
    end
  end
  return false
end

function checkPlayerCollisionWithEntyGates()
  for entryGateNum, entryGate in ipairs(mapManagerModule.getEntryGateTiles()) do
    if (collisionModule.collisionAABB(player, entryGate)) then
      teleportPlayerToPreviousMap()
      print("coll with entry gate")
    end
  end
end

function checkPlayerCollisionWithExitGates()
  for exitGateNum, exitGate in ipairs(mapManagerModule.getExitGateTiles()) do
    if (collisionModule.collisionAABB(player, exitGate)) then
      teleportPlayerToNextMap()
      print("coll with exit gate")
    end
  end
end

function teleportPlayerToPreviousMap()
  if(mapManagerModule.getCurrentMap().previousMap)then
    mapManagerModule.loadMapPackageAndBuildTiles(mapManagerModule.getCurrentMap().previousMap)
    if( mapManagerModule.getExitSpawnPoints()) then
      player.x = mapManagerModule.getExitSpawnPoints()[1].x
      player.y = mapManagerModule.getExitSpawnPoints()[1].y
    end
  end
end

function teleportPlayerToNextMap()
  if(mapManagerModule.getCurrentMap().nextMap) then
    print("mapManagerModule.getCurrentMap().nextMap" .. mapManagerModule.getCurrentMap().nextMap)
    mapManagerModule.loadMapPackageAndBuildTiles(mapManagerModule.getCurrentMap().nextMap)
    if (mapManagerModule.getEntrySpawnPoints()) then
      player.x = mapManagerModule.getEntrySpawnPoints()[1].x
      player.y = mapManagerModule.getEntrySpawnPoints()[1],y
    end
  end
end

function playerModule.drawPlayer()
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end

return playerModule