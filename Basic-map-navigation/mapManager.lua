local mapManagerModule = {}

function loadMapPackageModule(mapRequireName)
    local map = require(mapRequireName)
    return map
end

local currentLoadedMap = loadMapPackageModule("maps/map-1")

function unloadMapPackageModule(mapModuleName)
    package.loaded[mapModuleName] = nil
    
end

function mapManagerModule.buildMapTiles(theMap)
    local tiles = {}
  for rowNum, row in ipairs(theMap) do
    for columnNumber, tileValue in ipairs(row) do
      if tileValue == 1 then -- add only tiles with value 1 of the map
        table.insert(tiles, {
          x = (columnNumber - 1) * theMap.cellWidth + (theMap.x),
          y = (rowNum - 1) * theMap.cellHeight + (theMap.y),
          width = theMap.cellWidth,
          height = theMap.cellHeight,
        })
      end
    end
  end
  return tiles
end

local builtTiles = mapManagerModule.buildMapTiles(currentLoadedMap)

function mapManagerModule.drawMap()
    
    for i, tile in ipairs(builtTiles) do
        love.graphics.rectangle("line", tile.x, tile.x, tile.width, tile.height)
    end
end


return mapManagerModule