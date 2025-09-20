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
          })
      end
    end
  end
  return tiles
end

local builtTiles = buildGrid()

function aabbCollision(aa, bb)
  return aa.x < bb.x + gridCellDimension and
    aa.x + aa.width > bb.x and
    aa.y < bb.y + gridCellDimension and
    aa.y + aa.height > bb.y
end

function gridModule.checkCollisionsBetweenPlayerAndTiles(player)
  for _, tile in ipairs(builtTiles) do
    if aabbCollision(player, tile) then
      return true
    end
  end
  return false
end

function gridModule.draw()
  for i, tile in ipairs(builtTiles) do
    love.graphics.rectangle("line", tile.x, tile.y, gridCellDimension, gridCellDimension)
  end
end


return gridModule