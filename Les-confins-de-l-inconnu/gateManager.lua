local gateManagerModule = {}
local mapManagerModule = require("mapManager")
local collisionModule = require("collision")

-- Internal helper
local function teleportPlayer(player, targetMapName, gate)
    mapManagerModule.loadMapPackageAndBuildTiles(targetMapName)

    local gates = mapManagerModule.getCurrentMap().gates
    local destinationGate = gates[gate.targetGate]

    if destinationGate then
        -- Offset player based on direction they came from
        if gate.targetGate == "north" then
            player.y = destinationGate.y + destinationGate.height
            player.x = destinationGate.x + (destinationGate.width / 2) - (player.width / 2)
        elseif gate.targetGate == "south" then
            player.y = destinationGate.y - player.height
            player.x = destinationGate.x + (destinationGate.width / 2) - (player.width / 2)
        elseif gate.targetGate == "west" then
            player.x = destinationGate.x + destinationGate.width
            player.y = destinationGate.y + (destinationGate.height / 2) - (player.height / 2)
        elseif gate.targetGate == "east" then
            player.x = destinationGate.x - player.width
            player.y = destinationGate.y + (destinationGate.height / 2) - (player.height / 2)
        end
    else
        print("Could not find targetGate: " .. gate.targetGate .. " in map: " .. targetMapName)
    end
end

-- This function now checks AND teleports
function gateManagerModule.checkGateCollision(player)
    for gateName, gate in pairs(mapManagerModule.getCurrentMap().gates) do
        if collisionModule.collisionAABB(player, gate) then
            teleportPlayer(player, gate.targetMap, gate)
            return true -- Indicate a teleport occurred
        end
    end
    return false -- No teleport
end

function gateManagerModule.drawGates()
    for name, gate in pairs(mapManagerModule.getCurrentMap().gates) do
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("line", gate.x, gate.y, gate.width, gate.height)
    end
end

return gateManagerModule
