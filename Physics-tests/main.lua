io.stdout:setvbuf("no")

local gridModule = require("grid")
local playerModule = require("player-no-vec-limit-diag-speed")

function love.update(dt)
  playerModule.update(dt)
end

function love.draw()
  
  playerModule.draw()
  
  gridModule.draw()
end