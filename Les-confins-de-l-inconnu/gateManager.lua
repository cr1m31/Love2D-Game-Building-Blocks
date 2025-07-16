local gateManagerModule = {}
local mapManagerModule = require("mapManager")
local collisionModule = require("collision")

function gateManagerModule.checkGateCollision(player)
    for gateName, gate in pairs(mapManagerModule.getCurrentMap().gates) do
        if collisionModule.collisionAABB(player, gate) then
            return gateName, gate
        end
    end
    return nil
end

function gateManagerModule.drawGates()
    for name, gate in pairs(mapManagerModule.getCurrentMap().gates) do
        love.graphics.setColor(1,0,0)
        love.graphics.rectangle("line", gate.x, gate.y, gate.width, gate.height)
    end
end

return gateManagerModule
