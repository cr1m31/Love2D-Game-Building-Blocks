local playerModule = {}

local collisionModule = require("collision")

local mapManagerModule = require("mapManager")

local gateManagerModule = require("gateManager")

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
  checkCollisionWithGate()
end

function checkCollisionWithGate()
  local gateName, gate = gateManagerModule.checkGateCollision(player) 
  if (gate) then
    print("gateName: " .. gateName .. " targetMap: ".. gate.targetMap)
    teleportPlayer(gate.targetMap, gate)
  else
    
  end
end

function teleportPlayer(targetMapName, gate)
  mapManagerModule.loadMapPackageAndBuildTiles(targetMapName)

  local gates = mapManagerModule.getCurrentMap().gates
  local destinationGate = gates[gate.targetGate]

  if destinationGate then
    -- Center player inside gate
    local baseX = destinationGate.x + (destinationGate.width - player.width) / 2
    local baseY = destinationGate.y + (destinationGate.height - player.height) / 2

    -- Offset player based on direction they came from
    if gate.targetGate == "north" then
      player.x = baseX
      player.y = destinationGate.y + player.height
    elseif gate.targetGate == "south" then
      player.x = baseX
      player.y = destinationGate.y - player.height
    elseif gate.targetGate == "west" then
      player.x = destinationGate.x + player.width
      player.y = baseY
    elseif gate.targetGate == "east" then
      player.x = destinationGate.x - player.width
      player.y = baseY
    else
      -- Fallback if direction is unclear
      player.x = baseX
      player.y = baseY
    end
  else
    print("⚠ Could not find targetGate: " .. gate.targetGate .. " in map: " .. targetMapName)
  end
end



function checkPlayerCollisions()
  for tileNum, tile in ipairs(mapManagerModule.getBuiltTiles()) do
    if (collisionModule.collisionAABB(player, tile)) then 
      return true   
    end
  end
  return false
end

function playerModule.drawPlayer()
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end

return playerModule