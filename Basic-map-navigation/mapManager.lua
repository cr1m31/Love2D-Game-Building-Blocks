local mapManagerModule = {}

function loadMapPackageModule(mapRequireName)
    local map = require(mapRequireName)
    return map
end

local currentLoadedMap = loadMapPackageModule("maps/map-1")

function unloadMapPackageModule(mapModuleName)
    package.loaded[mapModuleName] = nil
    
end

function mapManagerModule.buildMap()
    
end

function mapManagerModule.drawMap()
    for rowIndex, row  in ipairs(currentLoadedMap) do
        for colIndex, cellValue in ipairs(row) do
            if (cellValue == 1) then 
                print(cellValue)
                local cellX = currentLoadedMap.x + (colIndex -1) * currentLoadedMap.cellWidth
                local cellY = currentLoadedMap.y + (rowIndex -1) * currentLoadedMap.cellHeight
                love.graphics.rectangle("line", cellX, cellY, currentLoadedMap.cellWidth, currentLoadedMap.cellHeight)
            end
        end
    end
end


return mapManagerModule