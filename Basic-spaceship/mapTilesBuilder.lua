local mapTilesBuilder = {}

-- keep 32 pixels for cells to fit to screen
local cell = {
    width = 32,
    height = 32,
}

local builtTiles = {}
local currentMapModule = nil

local function buildMapTileLocations(theMap)
  local tiles = {}
  for rowNum, row in ipairs(theMap) do
    for columnNumber, tileValue in ipairs(row) do
      if tileValue == 1 then -- add only tiles with value 1 of the map
        table.insert(tiles, {
          x = (columnNumber - 1) * theMap.cellWidth + (theMap.x or 0),
          y = (rowNum - 1) * theMap.cellHeight + (theMap.y or 0),
          width = theMap.cellWidth,
          height = theMap.cellHeight,
        })
      end
    end
  end
  return tiles
end

function mapTilesBuilder.loadBuiltTiles(mapNumber)
  -- Unload previous map module from package.loaded cache
  local oldMapName = currentMapModule and currentMapModule._name
  if oldMapName then
    package.loaded[oldMapName] = nil
  end

  builtTiles = {}

  local mapName = "maps/map-" .. tostring(mapNumber)
  package.loaded[mapName] = nil  -- forcibly unload it to reload fresh

  currentMapModule = require(mapName)
  currentMapModule._name = mapName  -- store the name so we can unload next time

  builtTiles = buildMapTileLocations(currentMapModule)
end


function mapTilesBuilder.getBuiltTilesInCollisions()
  return builtTiles
end

function mapTilesBuilder.drawTilesOnMap()
  for _, tile in ipairs(builtTiles) do
    love.graphics.setColor(0.7, 0.7, 0.7)
    love.graphics.rectangle("fill", tile.x, tile.y, currentMapModule.cellWidth, currentMapModule.cellHeight)
  end
end

-- Optional getter for the current map data (for collision checks, holes, etc)
function mapTilesBuilder.getCurrentMap()
  return currentMapModule
end

return mapTilesBuilder
