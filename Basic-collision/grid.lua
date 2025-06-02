local gridModule = {}

local grid = {
  {1,0,0,0,0,0,0,0,0,0,0,1},
  {0,0,0,1,1,0,0,0,1,1,0,0},
  {0,0,0,1,1,0,0,0,1,1,0,0},
  {0,0,0,1,1,0,0,0,1,1,0,0},
  {0,0,0,1,1,0,0,0,1,1,0,0},
  {0,0,0,1,1,0,0,0,1,1,0,0},
  {0,0,0,1,1,0,0,0,1,1,0,0},
  {0,0,0,1,1,0,0,0,1,1,0,0},
  {1,0,0,0,0,0,0,0,0,0,0,1},
}

local cell = {
    width = 50,
    height = 50,
}

function gridModule.createGridTiles()
  local tileNum = 0
  for rowNumber, row in ipairs(grid) do
    for columnNumber, tileValue in ipairs(grid[rowNumber]) do
      tileNum = tileNum + 1
      if tileValue == 1 then
        print("tileNum: " .. tileNum)
        print("rowNumber: " .. rowNumber .. "\ncell y: " .. rowNumber * cell.height)
        print("columnNumber: " .. columnNumber .. "\ncell x: " .. columnNumber * cell.width)
      end
    end
  end
end

function gridModule.drawGrid()
  for rowNumber, row in ipairs(grid) do
    for columnNumber, tileValue in ipairs(grid[rowNumber]) do
      if tileValue == 0 then
        -- love.graphics.setColor(1,0,0)
        love.graphics.rectangle("line", cell.width * (columnNumber - 1), cell.height * (rowNumber - 1), cell.width, cell.height)
      end
      
      if tileValue == 1 then
        love.graphics.setColor(1,1,1)
        love.graphics.rectangle("fill", cell.width * (columnNumber - 1), cell.height * (rowNumber - 1), cell.width, cell.height)
      end
    end
  end
end


return gridModule