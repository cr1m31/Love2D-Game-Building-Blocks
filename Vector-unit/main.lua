io.stdout:setvbuf("no") -- disable output buffering to see debug text directly in output when running game

local vectorUnitModule = require("vectorLogic")
local playerModule = require("player")

function love.update(dt)
  playerModule.update(dt)
end

function love.draw()
  playerModule.draw()
  
  vectorUnitModule.draw()  
end
