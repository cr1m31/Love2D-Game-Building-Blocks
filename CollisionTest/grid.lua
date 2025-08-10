local gridModule = {}

local grid = {
  {1,1,1,1,1,1,1,1},
  {1,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,1},
  {1,1,1,1,1,1,1,1},
}

local gridCellDimension = 20

function buildGrid()
  local tiles = {}
  for rowNum, row in ipairs(grid) do
    for colNum, colValue in ipairs(grid[rowNum]) do
      if colValue == 1 then
        table.insert(
          tiles, 
          {
            x = (colNum - 1) * gridCellDimension,
            y = (rowNum - 1) * gridCellDimension,
            width = gridCellDimension,
            height = gridCellDimension,
          })
      end
    end
  end
  return tiles
end

local builtTiles = buildGrid()

local allTiles = 0
for lineNumber, line in ipairs(grid) do
  allTiles = lineNumber * #line
end

print("all tiles: " .. allTiles)

print("built tiles: " .. #builtTiles)

function gridModule.draw()
  for i, tile in ipairs(builtTiles) do
    love.graphics.rectangle("line", tile.x, tile.y, tile.width, tile.height)
  end
end


return gridModule