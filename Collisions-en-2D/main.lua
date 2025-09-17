io.stdout:setvbuf("no")

local gridModule = require("grid")
local playerModule = require("player")

function love.update()
  playerModule.update( love.mouse.getX(), love.mouse.getY() )
end

function love.draw()
  
  playerModule.draw()
  
  gridModule.draw()
end