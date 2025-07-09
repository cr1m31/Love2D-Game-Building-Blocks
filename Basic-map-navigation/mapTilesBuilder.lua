local mapTilesBuilder = {}

function buildMapTileLocations(theMap)
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

function buildGateTileLocations(theMap)
  local gates = {}
  gates.previousMap = {}
  gates.nextMap = {}
  for rowNum, row in ipairs(theMap) do
    for colNum, tileValue in ipairs(row) do
      if tileValue == 112 then
        table.insert(gates.previousMap, {
          x = (colNum -1) * theMap.cellWidth + (theMap.x or 0),
          y = (rowNum -1) * theMap.cellHeight + (theMap.y or 0),
          width = theMap.cellWidth,
          height = theMap.cellHeight,
        })
      end
      if tileValue == 111 then
        table.insert(gates.nextMap, {
          x = (colNum -1) * theMap.cellWidth + (theMap.x or 0),
          y = (rowNum -1) * theMap.cellHeight + (theMap.y or 0),
          width = theMap.cellWidth,
          height = theMap.cellHeight,
        })
      end
    end
  end
  return gates
end

function buildSpawnLocations(theMap)
  local spawners = {}
  spawners.inside = {}
  spawners.outside = {}
  for rowNum, row in ipairs(theMap) do
    for colNum, tileValue in ipairs(row) do
      if tileValue == 115 then
        table.insert(spawners.inside, {
          x = (colNum -1) * theMap.cellWidth + (theMap.x or 0),
          y = (rowNum -1) * theMap.cellHeight + (theMap.y or 0),
          width = theMap.cellWidth,
          height = theMap.cellHeight,
        })
      end
      if tileValue == 116 then
        table.insert(spawners.outside, {
          x = (colNum -1) * theMap.cellWidth + (theMap.x or 0),
          y = (rowNum -1) * theMap.cellHeight + (theMap.y or 0),
          width = theMap.cellWidth,
          height = theMap.cellHeight,
        })
      end
    end
  end
  return spawners
end

local builtTiles = {}
local currentMapModule = nil
local builtGates = {}
local builtSpawners = {}

function mapTilesBuilder.loadBuiltTiles(mapNumber)
  -- Unload previous map module from package.loaded cache
  local oldMapName = currentMapModule and currentMapModule._name
  if oldMapName then
    package.loaded[oldMapName] = nil
  end

  builtTiles = {}
  builtGates = {}
  builtSpawners = {}

  local mapName = "maps/map-" .. tostring(mapNumber)
  package.loaded[mapName] = nil  -- forcibly unload it to reload fresh

  currentMapModule = require(mapName)
  currentMapModule._name = mapName  -- store the name so we can unload next time

  builtTiles = buildMapTileLocations(currentMapModule)
  builtGates = buildGateTileLocations(currentMapModule)
  builtSpawners = buildSpawnLocations(currentMapModule)
end


function mapTilesBuilder.getBuiltTilesInCollisions()
  return builtTiles
end

function mapTilesBuilder.getBuiltTileGates()
  return builtGates
end

function mapTilesBuilder.getBuiltTileSpawners()
  return builtSpawners
end

function mapTilesBuilder.drawTilesOnMap()
  for _, tile in ipairs(builtTiles) do
    love.graphics.setColor(0.7, 0.7, 0.7)
    love.graphics.rectangle("fill", tile.x, tile.y, currentMapModule.cellWidth, currentMapModule.cellHeight)
  end
  -- Draw gates
for _, tile in ipairs(builtGates.previousMap or {}) do
  love.graphics.setColor(0.2, 1, 0.2) -- green
  love.graphics.rectangle("fill", tile.x, tile.y, tile.width, tile.height)
end

for _, tile in ipairs(builtGates.nextMap or {}) do
  love.graphics.setColor(0.1, 0.6, 0.1) -- darker green
  love.graphics.rectangle("fill", tile.x, tile.y, tile.width, tile.height)
end

-- Draw spawners
for _, tile in ipairs(builtSpawners.inside or {}) do
  love.graphics.setColor(1, 1, 0.3) -- yellow
  love.graphics.rectangle("fill", tile.x, tile.y, tile.width, tile.height)
end

for _, tile in ipairs(builtSpawners.outside or {}) do
  love.graphics.setColor(1, 0.8, 0.3) -- orange-yellow
  love.graphics.rectangle("fill", tile.x, tile.y, tile.width, tile.height)
end

end

-- Optional getter for the current map data (for collision checks, holes, etc)
function mapTilesBuilder.getCurrentMap()
  return currentMapModule
end

return mapTilesBuilder
