io.stdout:setvbuf("no")

local gridModule = require("grid")
local playerModule = require("player-v1")

function love.update(dt)
  playerModule.update(dt)
end

function love.draw()
  
  playerModule.draw()
  
  gridModule.draw()
end