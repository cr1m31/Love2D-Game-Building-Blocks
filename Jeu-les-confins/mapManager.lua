local mapManagerModule = {}

function loadMapPackageModule(mapRequireName)
    local map = require(mapRequireName)
    return map
end

local currentLoadedMap = nil

function unloadMapPackageModule(mapModuleName)
  if mapModuleName == nil then
  else
    package.loaded[mapModuleName] = nil
  end
end

function mapManagerModule.buildMapCollisionTiles(theMap)
  local tiles = {}
  for rowNum, row in ipairs(theMap.collisionTiles) do
    for columnNumber, tileValue in ipairs(row) do
      if tileValue == 1 then
        table.insert(tiles, {
          x = (columnNumber - 1) * theMap.map.cellWidth + theMap.map.x,
          y = (rowNum - 1) * theMap.map.cellHeight + theMap.map.y,
          width = theMap.map.cellWidth,
          height = theMap.map.cellHeight,
        })
      end
    end
  end
  return tiles
end

function mapManagerModule.buildMapTiles(theMap)
  local tiles = {}
  for rowNum, row in ipairs(theMap.tiles) do
    for columnNumber, tileValue in ipairs(row) do
      if tileValue == 1 then
        table.insert(tiles, {
          x = (columnNumber - 1) * theMap.map.cellWidth + theMap.map.x,
          y = (rowNum - 1) * theMap.map.cellHeight + theMap.map.y,
          width = theMap.map.cellWidth,
          height = theMap.map.cellHeight,
          value = tileValue,
        })
      end
    end
  end
  return tiles
end

local builtCollisionTiles = {}
local builtTiles = {}

function mapManagerModule.loadMapPackageAndBuildTiles(mapName)
  local mapsDir = "maps/"
  currentLoadedMap = loadMapPackageModule(mapsDir .. mapName)
  builtCollisionTiles = mapManagerModule.buildMapCollisionTiles(currentLoadedMap)
  builtTiles = mapManagerModule.buildMapTiles(currentLoadedMap)
  if currentLoadedMap.map.previousMap ~= nil then
    unloadMapPackageModule(mapsDir .. currentLoadedMap.map.previousMap)
  end
end

function mapManagerModule.getCurrentMap()
  if currentLoadedMap == nil then
    return nil
  else
    return currentLoadedMap
  end
end

function mapManagerModule.getBuiltCollisionTiles()
  return builtCollisionTiles
end

function mapManagerModule.getBuiltTiles()
  return builtTiles
end

function mapManagerModule.drawCollisionTiles()
  love.graphics.setColor(1, 1, 1)  -- Reset color to white
  for i, tile in ipairs(builtCollisionTiles) do
    love.graphics.rectangle("line", tile.x, tile.y, tile.width, tile.height)
  end
end


function mapManagerModule.drawMapTiles()
  for i, tile in ipairs(builtTiles) do
    if tile.value == 1 then
      love.graphics.setColor(0, 0, 1)  -- Blue
    elseif tile.value == 2 then
      love.graphics.setColor(1, 0, 0)  -- Red
    end
    love.graphics.rectangle("line", tile.x, tile.y, tile.width, tile.height)
  end

  love.graphics.setColor(1, 1, 1)  -- Reset color after drawing
end


return mapManagerModule
