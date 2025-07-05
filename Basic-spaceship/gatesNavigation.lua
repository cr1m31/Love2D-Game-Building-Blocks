local gatesNavigationModule = {}

local mapTilesBuilder = require("mapTilesBuilder")

function gatesNavigationModule.drawGates()
    for i, v in ipairs(mapTilesBuilder.getBuiltTileGates()) do
        love.graphics.setColor(0.5,1,0.5)
        love.graphics.rectangle("line", v.x, v.y, v.width, v.height)
    end
end


return gatesNavigationModule