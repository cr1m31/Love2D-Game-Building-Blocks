io.stdout:setvbuf("no")

local gridModule = require("grid")
local playerModule = require("player")

function love.update(dt)
  playerModule.update(dt)
end

function love.draw()
  gridModule.draw()
  playerModule.draw()
end