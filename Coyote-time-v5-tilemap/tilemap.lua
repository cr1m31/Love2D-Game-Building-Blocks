local tilemapModule = {}

local tileDim = 50
function buildTiles()
  local tiles = {}
  for line = 1, 10 do
    for col = 1, 10 do
      table.insert(
        tiles,
        {
          x = (col - 1) * tileDim,
          y = (line - 1) * tileDim,
        })
    end
  end
  return tiles
end

function drawTiles()
  for tileNum, tiles in ipairs(buildTiles()) do
    love.graphics.rectangle("line", tiles.x, tiles.y, tileDim, tileDim)
  end
end

function tilemapModule.load()
  buildTiles()
  for tileNum, tiles in ipairs(buildTiles()) do
    print("tileNum : " .. tileNum)
    print("x : " .. tiles.x .. "\ny : " .. tiles.y)
  end
  
  
end


function tilemapModule.draw()
  drawTiles()
end

return tilemapModule