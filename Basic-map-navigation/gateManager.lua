local gateManagerModule = {}
local mapManagerModule = require("mapManager")

function gateManagerModule.loadGates()
    for k, v in pairs(mapManagerModule.getCurrentMap().gates) do
        print("Gate: ", k, " x:", v.x, " Y:", v.y)
    end
end

function gateManagerModule.drawGates()
    local gates = mapManagerModule.getCurrentMap().gates
    local map = mapManagerModule.getCurrentMap().map
    local gateWidth = nil
    local gateHeight = nil
    for k, v in pairs(gates) do
        if (v.targetGate == "east" or v.targetGate == "west") then
            gateWidth = map.cellWidth
            gateHeight = map.cellHeight * 3
        else
            gateWidth = map.cellWidth * 3
            gateHeight = map.cellHeight
        end
        
        love.graphics.rectangle("line", v.x * map.cellWidth, v.y * map.cellHeight, gateWidth, gateHeight)
    end
    
end

return gateManagerModule