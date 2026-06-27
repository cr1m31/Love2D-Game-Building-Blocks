local playerModule = {}

local player = {
  x = 100,
  y = 400,
  width = 20,
  height = 30,
}

local tilemap = {}

function drawTiles()
  local y = 0
  local x = 0
  for line = 1, 10 do
    y = line * 50
    for col = 1, 10 do
      x = col * 50
      love.graphics.rectangle("line", x, y, 50, 50)
      print("x : " .. x .. " y : " .. y)
    end
  end
  
end


function playerModule.load()
  
end

function playerModule.update(dt)
  
end

function playerModule.draw()
  drawTiles()
end


return playerModule