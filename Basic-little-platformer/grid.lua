local gridModule = {}

local grid = {
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,0,0,1,1,0,0,0,1,1,0,0,0,0,0,1},
  {1,0,0,1,1,0,0,0,1,1,0,0,0,0,0,1},
  {1,0,0,1,1,0,0,0,1,1,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,1,1,0,0,0,1,1,0,0,0,0,0,1},
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
}

local cell = {
    width = 50,
    height = 50,
}

local buildedTiles = {}

function buildGridTileLocations()
  tiles = {}
  for rowNum, row in ipairs(grid) do
    for columnNumber, tileValue in ipairs(grid[rowNum]) do
      if tileValue == 1 then -- add only tiles with value 1 of the grid
        table.insert(tiles, {
          x = (columnNumber -1) * cell.width,
          y = (rowNum -1) * cell.height,
          width = cell.width,
          height = cell.height,
        })
      end
    end
  end
  return tiles
end

function gridModule.loadBuildedTiles()
  buildedTiles = buildGridTileLocations()
end

function gridModule.getBuildedTilesInCollisions()
  return buildGridTileLocations()
end

function gridModule.drawTilesOnGrid()
  for tileNum, tile in ipairs(buildedTiles) do
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill", tile.x, tile.y, cell.width, cell.height)
    
  end
end

return gridModule