io.stdout:setvbuf("no") -- disable output buffering to see debug text directly in output when running game

local vectorUnitModule = require("vector-unit")
local playerModule = require("player")

function love.update()
  
  playerModule.update()
  
  vectorUnitModule.update()
  
  
end

function love.draw()
  playerModule.draw()
  
  vectorUnitModule.draw()  
end
