local mapManagerModule = {}

function loadMapPackageModule(mapRequireName)
    local map = require(mapRequireName)
    return map
end

local currentLoadedMap = nil

function unloadMapPackageModule(mapModuleName)
  if(mapModuleName == nil) then
  else
    package.loaded[mapModuleName] = nil
  end
end

function mapManagerModule.buildMapTiles(theMap)
    local tiles = {}
    local entryGates = {}
    local exitGates = {}
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

      if tileValue == 101 then -- add only entry gates with value 101 of the map
        table.insert(entryGates, {
          x = (columnNumber - 1) * theMap.cellWidth + (theMap.x),
          y = (rowNum - 1) * theMap.cellHeight + (theMap.y),
          width = theMap.cellWidth,
          height = theMap.cellHeight,
        })
      end

      if tileValue == 120 then -- add only exit gates with value 120 of the map
        table.insert(exitGates, {
          x = (columnNumber - 1) * theMap.cellWidth + (theMap.x),
          y = (rowNum - 1) * theMap.cellHeight + (theMap.y),
          width = theMap.cellWidth,
          height = theMap.cellHeight,
        })
      end

    end
  end
  return tiles, entryGates, exitGates
end


local builtTiles = {}
local entryGates = {}
local exitGates = {}

function mapManagerModule.loadMapPackageAndBuildTiles(mapName)
  local mapsDir = "maps/"
  currentLoadedMap = loadMapPackageModule(mapsDir .. mapName)
  builtTiles, entryGates, exitGates = mapManagerModule.buildMapTiles(currentLoadedMap)

  if currentLoadedMap.previousMap ~= nil then
    unloadMapPackageModule(mapsDir .. currentLoadedMap.previousMap)
  end
end

function mapManagerModule.getCurrentMap()
  if currentLoadedMap == nil then
    return nil
  else
    return currentLoadedMap
  end
end

function mapManagerModule.drawMap()
    
    for i, tile in ipairs(builtTiles) do
        love.graphics.rectangle("fill", tile.x, tile.y, tile.width, tile.height)
    end

    for entryGateNum, entryGate in ipairs(entryGates) do
      love.graphics.setColor(0,1,0)
      love.graphics.rectangle("line", entryGate.x, entryGate.y, entryGate.width, entryGate.height)
    end

    for exiGateNum, exitGate in ipairs(exitGates) do
      love.graphics.setColor(0,1,1)
      love.graphics.rectangle("line", exitGate.x, exitGate.y, exitGate.width, exitGate.height)
    end
end


return mapManagerModule